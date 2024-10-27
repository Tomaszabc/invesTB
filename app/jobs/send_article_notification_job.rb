class SendArticleNotificationJob < ApplicationJob
  queue_as :default

  def perform(article_id)
        # Do something later
    article = Article.find(article.id)
    User.subscribed_to_newsletter.find_each do |user|
      ArticleMailer.new_article_notification(article, user).deliver_now
    end
  end
end
