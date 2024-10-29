class ArticleMailer < ApplicationMailer
  default to: "example@user.com"

  def notification_email(article)
    @article = article
    mail(subject: "Notification for Article #{article.id}")
  end
end
