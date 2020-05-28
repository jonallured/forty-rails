Devise.setup do |config|
  require 'devise/orm/active_record'

  config.case_insensitive_keys = [:email]
  config.email_regexp = /\A[^@\s]+@[^@\s]+\z/
  config.expire_all_remember_me_on_sign_out = true
  config.extend_remember_period = true
  config.mailer_sender = 'no-reply@fortyeven.com'
  config.password_length = 18..128
  config.reconfirmable = true
  config.remember_for = 2.weeks
  config.reset_password_within = 6.hours
  config.sign_in_after_reset_password = false
  config.sign_out_via = :delete
  config.skip_session_storage = [:http_auth]
  config.stretches = Rails.env.test? ? 1 : 11
  config.strip_whitespace_keys = [:email]
end

module DeviseUser
  def self.path_names
    {
      confirmation: 'confirm',
      password: 'password',
      registration: 'registration',
      sign_in: 'sign-in',
      sign_out: 'sign-out',
      sign_up: 'sign-up'
    }
  end

  def self.route_options
    {
      path: '',
      path_names: path_names,
      sign_out_via: :get
    }
  end
end
