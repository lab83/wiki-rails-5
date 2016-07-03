Rails.application.config.action_mailer.smtp_settings = {
  address:   ENV["SMTP_ADDRESS"],
  port:      ENV["SMTP_PORT"],
  user_name: ENV["SMTP_USER_NAME"],
  password:  ENV["SMTP_PASSWORD"]
}
