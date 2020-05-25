module Forty
  def self.config
    @config ||= create_config
  end

  private_class_method def self.create_config
    attributes = load_config
    Struct.new('Config', *attributes.keys, keyword_init: true)
    Struct::Config.new(attributes)
  end

  private_class_method def self.load_config # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    credentials = Rails.application.credentials
    name = ENV.fetch('CREDS_GROUP', 'invalid').to_sym
    group = credentials[name]

    raise "CREDS_GROUP '#{name}' not found" unless group

    {
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
end

Forty.config
