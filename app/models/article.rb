class Article < ApplicationRecord
  has_rich_text :content
  has_one_attached :article_image

  def resized_article_image
    return unless article_image.attached?

    article_image.variant(resize_to_limit: [700, 350]).processed
  end
end
