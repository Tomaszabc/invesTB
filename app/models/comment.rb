class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true
  has_rich_text :content

  validates :content, no_attachments: true
  validate :content_presence
  validates :username, presence: {message: "Nazwa użytkownika nie może być pusta"}, unless: -> { user.present? }

  private

  def content_presence
    if content.to_plain_text.blank? && !contains_image?
      errors.add(:content, "Treść komentarza nie może być pusta")
    end
  end

  def contains_image?
    content.embeds.present?
  end
end
