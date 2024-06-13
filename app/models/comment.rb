class Comment < ApplicationRecord
  belongs_to :article
  belongs_to :user, optional: true
  has_rich_text :content

  validate :content_presence
  validate :content_length
  validates :username, presence: { message: "Nazwa użytkownika nie może być pusta" }, length: { maximum: 25, message: "Nazwa użytkownika nie może być dłuższa niż 25 znaków" }, unless: -> { user.present? }
  validate :rate_limit, on: :create
  validate :restricted_username
  validate :valid_image_formats
  validate :image_size

  after_save :moderate_images

  private

  VALID_IMAGE_FORMATS = %w[image/png image/jpeg image/jpg image/gif].freeze
  MAX_IMAGE_SIZE_MB = 8

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

  def valid_image_formats
    content.body.attachments.each do |attachment|
      if attachment.image? && !VALID_IMAGE_FORMATS.include?(attachment.blob.content_type)
        errors.add(:content, "Obraz może być tylko w formatach: #{VALID_IMAGE_FORMATS.join(', ')}")
      end
    end
  end

  def image_size
    content.body.attachments.each do |attachment|
      if attachment.image? && attachment.blob.byte_size > MAX_IMAGE_SIZE_MB.megabytes
        errors.add(:content, "Obraz nie może być większy niż #{MAX_IMAGE_SIZE_MB}MB")
      end
    end
  end

  def moderate_images
    content.body.attachments.each do |attachment|
      if attachment.image?
        moderation_service = ImageModerationService.new(attachment.key)

        if moderation_service.moderate_image
          moderation_service.delete_image
          attachment.purge
          errors.add(:content, "Obraz zawiera nieodpowiednie treści")
          raise ActiveRecord::RecordInvalid.new(self)
        end
      end
    end
  end
end
