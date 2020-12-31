Honeybadger.configure do |config|
  config.api_key = Forty.config.honeybadger_api_key
  config.env = Forty.config.honeybadger_env
end
