class Article < ApplicationRecord
  before_create :set_sequential_number
  before_save :generate_slug
  after_save :notify_subscribers, if: :should_notify_subscribers?

  has_many :comments, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_one_attached :article_image

  enum category: {analysis: "analysis", articles: "articles", top_article: "top_article"}

  validates :title, presence: true
  validates :content, presence: true
  validates :description, presence: true

  scope :top_articles, -> { where(category: "top_article") }

  def resized_article_image
    return unless article_image.attached?

    article_image.variant(resize_to_limit: [700, 350]).processed
  end

  def generate_slug
    self.slug = title.parameterize if title.present?
  end

  def to_param
    slug
  end

  private

  def set_sequential_number
    self.sequential_number = Article.maximum(:sequential_number).to_i + 1
  end

  def should_notify_subscribers?
    saved_change_to_publish? && publish == true
  end

  def notify_subscribers
    SendArticleNotificationJob.perform_later(id)
  end
end
