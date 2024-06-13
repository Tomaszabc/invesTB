class CommentsController < ApplicationController
  before_action :set_article
  before_action :set_comment, only: [:edit, :update, :destroy]
  

  def show
    respond_to do |format|
      format.html { redirect_to @article }
      format.turbo_stream { render turbo_stream: turbo_stream.replace(dom_id(@comment), partial: "comments/comment", locals: {comment: @comment}) }
    end
  end

  def create
    @comment = @article.comments.build(comment_params)
    if user_signed_in?
      @comment.user = current_user
    else
      @comment.username = params[:comment][:username]
    end
    if @comment.save
      session[:comment_ids] ||= []
      session[:comment_ids] << @comment.id
      respond_to do |format|
        format.turbo_stream { flash.now[:notice] = "Komentarz dodany" }
        format.html { redirect_to @article, notice: "Komentarz dodany." }
      end
    else
      respond_to do |format|
        format.turbo_stream { render turbo_stream: turbo_stream.replace("new_comment_form", partial: "comments/form", locals: {article: @article, comment: @comment}) }
        format.html { redirect_to @article, alert: "Komentarz nie może być utworzony" }
      end
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])

    if can_delete_comment?(@comment)
      @comment.destroy
      respond_to do |format|
        format.html { redirect_to @article, notice: "Komentarz usunięty" }
        format.turbo_stream do
          flash.now[:notice] = "Komentarz usunięty"
          render turbo_stream: [
            turbo_stream.remove(@comment),
            turbo_stream.append("flash-messages", partial: "shared/flash_messages")
          ]
        end
      end
    else
      redirect_to @article, alert: "Nie masz uprawnień do usunięcia tego komentarza"
    end
  end

  def update
    respond_to do |format|
      if @comment.update(comment_params)
        format.turbo_stream do
          flash.now[:notice] = "Komentarz zaktualizowany"
          render turbo_stream: [
            turbo_stream.replace(@comment, partial: "comments/comment", locals: {comment: @comment}),
            turbo_stream.append("flash-messages", partial: "shared/flash_messages")
          ]
        end
        format.html { redirect_to @comment.article, notice: "Komentarz zaktualizowany." }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.turbo_stream do
          flash.now[:alert] = "Nie udało się zaktualizować komentarza."
          render turbo_stream: [
            turbo_stream.replace("comment_form", partial: "comments/form", locals: {article: @article, comment: @comment})
          ]
        end
      end
    end
  end

  def edit
    respond_to do |format|
      format.turbo_stream { render partial: "comments/edit_form", locals: {comment: @comment, article: @article} }
      format.html { render partial: "comments/edit_form", locals: {comment: @comment, article: @article} }
    end
  end

  private

      

  def set_article
    @article = Article.find_by!(slug: params[:article_slug])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path, alert: "Wystąpił błąd."
  end

  def set_comment
    @comment = @article.comments.find(params[:id])
  end

  def comment_params
    params.require(:comment).permit(:content, :username, :image)
  end
end
