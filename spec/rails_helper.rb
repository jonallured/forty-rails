require 'spec_helper'

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../config/environment', __dir__)
# Prevent database truncation if the environment is production
abort('Rails is running in production mode!') if Rails.env.production?
require 'rspec/rails'
require 'webmock/rspec'
# Add additional requires below this line. Rails is not loaded until this point!

ActiveRecord::Migration.maintain_test_schema!

RSpec.configure do |config|
  config.filter_rails_from_backtrace!
  config.infer_spec_type_from_file_location!
  config.use_transactional_fixtures = true

  config.before(:each, type: :system) do
    config.include Warden::Test::Helpers
    Capybara.server = :puma, { Silent: true }
    driven_by :selenium_chrome_headless
  end

  config.after(:each, type: :system) do
    Warden.test_reset!
  end
end

WebMock.disable_net_connect!(allow_localhost: true)
