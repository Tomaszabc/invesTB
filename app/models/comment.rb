class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true
  has_rich_text :content
  validate :content_presence
  validates :username, presence: {message: "Nazwa użytkownika nie może być pusta"}, unless: -> { user.present? }

  private

  def content_presence
    if content.blank? && !contains_image?
      errors.add(:content, "Treść komentarza nie może być pusta")
    end
  end

  def cointains_image?
    content.to_plain_text.blank? && content.embeds.present?
  end
end
