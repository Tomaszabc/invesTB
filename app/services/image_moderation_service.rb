class ImageModerationService
  def initialize(s3_key)
    @s3_key = s3_key
    @rekognition_client = REKOGNITION_CLIENT
    @s3_client = S3_CLIENT
    @bucket = S3_BUCKET
  end

  def moderate_image
    begin
      Rails.logger.info "Moderating image..."
      response = @rekognition_client.detect_moderation_labels({
        image: {
          s3_object: {
            bucket: @bucket,
            name: @s3_key
          }
        }
      })

      Rails.logger.info "Moderation response: #{response.inspect}"
      response.moderation_labels.any?
    rescue Aws::Rekognition::Errors::ServiceError => e
      Rails.logger.error "Rekognition error: #{e.message}"
      false
    end
  end

  def delete_image
    begin
      @s3_client.delete_object(bucket: @bucket, key: @s3_key)
      Rails.logger.info "Deleted image from S3: #{@s3_key}"
    rescue Aws::S3::Errors::ServiceError => e
      Rails.logger.error "S3 delete error: #{e.message}"
    end
  end
end