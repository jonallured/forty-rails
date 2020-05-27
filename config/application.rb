require_relative 'boot'

require 'rails/all'

Bundler.require(*Rails.groups)

module Forty
  class Application < Rails::Application
    config.active_job.queue_adapter = :sidekiq
    config.active_record.schema_format = :sql
    config.load_defaults 6.0
  end
end
