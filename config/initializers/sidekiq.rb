# frozen_string_literal: true

if Rails.env.development?
  redis_db = ENV.fetch('REDIS_DB', 0)
  redis_config = { url: "redis://localhost:6379/#{redis_db}" }
  Sidekiq.configure_server { |config| config.redis = redis_config }
  Sidekiq.configure_client { |config| config.redis = redis_config }
end
