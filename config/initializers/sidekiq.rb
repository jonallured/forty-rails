# frozen_string_literal: true

if Rails.env.development?
  redis_db = ENV.fetch('REDIS_DB', 0)
  redis_config = { url: "redis://localhost:6379/#{redis_db}" }
  Sidekiq.configure_server { |config| config.redis = redis_config }
  Sidekiq.configure_client { |config| config.redis = redis_config }
end

# Protect against timing attacks:
# - See https://codahale.com/a-lesson-in-timing-attacks/
# - See https://thisdata.com/blog/timing-attacks-against-string-comparison/
# - Use & (do not use &&) so that it doesn't short circuit.
# - Use digests to stop length information leaking
#   (see also ActiveSupport::SecurityUtils.variable_size_secure_compare)
module SidekiqCreds
  def self.checker
    proc do |username, password|
      expected_username = Forty.config.sidekiq_admin_username
      expected_password = Forty.config.sidekiq_admin_password

      compare(username, expected_username) &
        compare(password, expected_password)
    end
  end

  def self.compare(provided, expected)
    hexed_provided = ::Digest::SHA256.hexdigest(provided)
    hexed_expected = ::Digest::SHA256.hexdigest(expected)

    ActiveSupport::SecurityUtils.secure_compare(hexed_provided, hexed_expected)
  end
end
