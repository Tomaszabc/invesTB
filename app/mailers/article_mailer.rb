class ArticleMailer < ApplicationMailer
  default to: "example@user.com"

  def notification_email(article, recipient_email)
    @article = article
    mail(to: recipient_email, subject: "Notification for Article #{article.title}")
  end
end
