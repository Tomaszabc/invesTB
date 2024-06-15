class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true
  has_rich_text :content

  validate :content_presence
  validate :content_length
  validates :username, presence: {message: "Nazwa użytkownika nie może być pusta"}, length: {maximum: 25, message: "Nazwa użytkownika nie może być dłuższa niż 25 znaków"}, unless: -> { user.present? }
  validate :rate_limit, on: :create
  validate :restricted_username

  after_save :moderate_images

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
    content.body.attachments.any?(&:image?)
  end

  def rate_limit
    comments_count = Comment.where("created_at >= ?", 1.hour.ago).count
    if comments_count >= 100
      errors.add(:base, "Wykryto przeciążenie bazy danych komentarzami.")
    end
  end

  def restricted_username
    if username.present? && username.downcase.include?("tomek in")
      errors.add(:username, "Nazwa użytkownika jest podobna do nazwy administratora.")
    end
  end

  def moderate_images
    content.body.attachments.each do |attachment|
      if attachment.is_a?(ActionText::Attachables::RemoteImage)
        moderate_remote_image(attachment)
      elsif attachment.respond_to?(:image?) && attachment.image?
        moderate_active_storage_image(attachment)
      end
    end
  end

  def moderate_active_storage_image(attachment)
    moderation_service = ImageModerationService.new(attachment.key)
     if moderation_service.moderate_image
        moderation_service.delete_image
        attachment.purge
        errors.add(:content, "Obraz zawiera nieodpowiednie treści")
        raise ActiveRecord::RecordInvalid.new(self)
    end
  end

  def moderate_remote_image(attachment)
    moderation_service = ImageModerationService.new(attachment.url)
    if moderation_service.moderate_image
      errors.add(:content, "Obraz zawiera nieodpowiednie treści")
      raise ActiveRecord::RecordInvalid.new(self)
    end
  end
end
