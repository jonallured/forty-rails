ActionMailer::Base.default_url_options = { host: Forty.config.email_host } if Rails.env.production?

ActionMailer::Base.smtp_settings = {
  address: Forty.config.smtp_address,
  authentication: Forty.config.smtp_authentication,
  domain: Forty.config.smtp_domain,
  enable_starttls_auto: true,
  password: Forty.config.smtp_password,
  port: Forty.config.smtp_port,
  user_name: Forty.config.smtp_user_name
}
