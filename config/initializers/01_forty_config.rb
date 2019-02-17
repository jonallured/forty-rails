module Forty
  def self.config
    @config ||= create_config
  end

  private_class_method def self.create_config
    attributes = load_config
    Struct.new("Config", *attributes.keys, keyword_init: true)
    Struct::Config.new(attributes)
  end

  private_class_method def self.load_config
    credentials = Rails.application.credentials
    name = ENV['CREDS_GROUP'].to_sym
    group = credentials[name]

    raise 'CREDS_GROUP not found' unless group

    {
      stripe_api_key: group[:stripe_api_key]
    }
  end
end

Forty.config
