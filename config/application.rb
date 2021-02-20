require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

Warning[:deprecated] = false

module Forty
  class Application < Rails::Application
    config.active_record.schema_format = :sql
    config.load_defaults 6.1
  end
end
