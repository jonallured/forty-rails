module Forty
  def self.config
    @config ||= create_config
  end

  private_class_method def self.create_config
    attributes = load_config
    Struct.new('Config', *attributes.keys, keyword_init: true)
    Struct::Config.new(attributes)
  end

  private_class_method def self.load_config
    credentials = Rails.application.credentials
    name = ENV.fetch('CREDS_GROUP', 'invalid').to_sym
    group = credentials[name]

    raise "CREDS_GROUP '#{name}' not found" unless group

    map_config(group)
  end

  private_class_method def self.map_config(group) # rubocop:disable Metrics/MethodLength
    {
      admin_email: group[:admin_email],
      email_host: group[:email_host],

      features: features,

      sidekiq_admin_username: group.dig(:sidekiq_admin, :username),
      sidekiq_admin_password: group.dig(:sidekiq_admin, :password),

      smtp_address: group.dig(:smtp, :address),
      smtp_authentication: group.dig(:smtp, :authentication),
      smtp_domain: group.dig(:smtp, :domain),
      smtp_password: group.dig(:smtp, :password),
      smtp_port: group.dig(:smtp, :port),
      smtp_user_name: group.dig(:smtp, :user_name),

      stripe_plan_id: group.dig(:stripe, :plan_id),
      stripe_private_key: group.dig(:stripe, :private_key),
      stripe_public_key: group.dig(:stripe, :public_key)
    }
  end

  private_class_method def self.features
    Feature::FLAGS.index_with do |feature|
      ENV.fetch(feature, 'false') == 'true'
    end
  end
end

Forty.config
