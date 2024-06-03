class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true
  has_rich_text :content

  validates :content, no_attachments: true
  validate :content_presence
  validate :content_length
  validates :username, presence: {message: "Nazwa użytkownika nie może być pusta"}, length: { maximum: 25, message: "Nazwa użytkownika nie może być dłuższa niż 25 znaków" }, unless: -> { user.present? }

  private

  def content_presence
    if content.to_plain_text.blank? && !contains_image?
      errors.add(:content, "Treść komentarza nie może być pusta")
    end
  end

  def content_length
    if content.to_plain_text.length > 10000
      errors.add(:content, "Treść komentarza nie może przekraczać 10000 znaków")
    end
  end

  def contains_image?
    content.embeds.present?
  end
end
