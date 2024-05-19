class Article < ApplicationRecord
  before_create :set_sequential_number
  before_save :generate_slug

  has_many :likes
  has_one_attached :article_image

  validates :title, presence: true
  validates :content, presence: true

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
end
