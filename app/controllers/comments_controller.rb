class CommentsController < ApplicationController
  before_action :set_article

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
        format.turbo_stream
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
        format.turbo_stream
      end
    else
      redirect_to @article, alert: "Nie masz uprawnień do usunięcia tego komentarza"
    end
  end

  private

  def set_article
    @article = Article.find_by!(slug: params[:article_slug])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path, alert: "Wystąpił błąd."
  end

  def comment_params
    params.require(:comment).permit(:content, :username)
  end
end
