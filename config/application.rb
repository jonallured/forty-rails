require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module FortyWeb
  class Application < Rails::Application
    config.active_record.schema_format = :sql
    config.load_defaults 5.2
  end
end
