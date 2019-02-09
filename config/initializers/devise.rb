Devise.setup do |config|
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.expire_all_remember_me_on_sign_out = true
  config.extend_remember_period = true
  config.mailer_sender = 'change-me@example.com'
  config.password_length = 18..128
  config.remember_for = 2.weeks
  config.reset_password_within = 6.hours
  config.sign_in_after_reset_password = false
  config.sign_out_via = :delete
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.strip_whitespace_keys = [:email]
end
