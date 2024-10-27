class ArticleMailer < ApplicationMailer
  def new_article_notification
    @article = article
    @user = user

    mail(
      to: @user.email,
      subject: "Nowy artykuł: #{@article.title}"
    )
  end
end
