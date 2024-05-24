class CommentsController < ApplicationController
  before_action :set_article

  def create
    @comment = @article.comments.build(comment_params)
    @comment.user = current_user
    if @comment.save
      respond_to do |format|
        format.html { redirect_to @article, notice: "Komentarz dodany." }
        format.turbo_stream
      end
    else
      redirect_to @article, alert: "Komentarz nie może być utworzony"
    end
  end

  def destroy
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article, notice: "Komentarz usunięty" }
      format.turbo_stream
    end
  end

  private

  def set_article
    @article = Article.find_by!(slug: params[:article_slug])
  rescue ActiveRecord::RecordNotFound
    redirect_to articles_path, alert: "Wystąpił błąd."
  end

  def comment_params
    params.require(:comment).permit(:content)
  end
end
