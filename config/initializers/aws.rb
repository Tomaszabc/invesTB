Aws.config.update({
  region: "eu-central-1",
  credentials: Aws::Credentials.new(
    Rails.application.credentials.dig(:aws, :access_key_id),
    Rails.application.credentials.dig(:aws, :secret_access_key)
  )
})

REKOGNITION_CLIENT = Aws::Rekognition::Client.new
S3_CLIENT = Aws::S3::Client.new
S3_BUCKET = "investb-frankfurt"
