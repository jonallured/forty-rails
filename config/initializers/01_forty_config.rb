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

    {
      stripe_plan_id: group.dig(:stripe, :plan_id),
      stripe_private_key: group.dig(:stripe, :private_key),
      stripe_public_key: group.dig(:stripe, :public_key)
    }
  end
end

Forty.config
