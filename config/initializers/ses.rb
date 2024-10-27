if Rails.application.credentials.aws&.dig(:ses)
  ActionMailer::Base.smtp_settings = {
    :address => 'email-smtp.eu-central-1.amazonaws.com', # use the endpoint from your AWS console
    :port => '587',
    :authentication => :plain,
    :user_name => Rails.application.credentials.dig(:aws, :ses, :user_name),
    :password => Rails.application.credentials.dig(:aws, :ses, :password),
    :enable_starttls_auto => true
  }
end