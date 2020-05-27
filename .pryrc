Pry.configure do |config|
  color_map = {
    'development' => 'green',
    'fallback' => 'white',
    'production' => 'red',
    'staging' => 'yellow',
    'test' => 'purple'
  }

  env_console_name = ENV['CONSOLE_COLOR_ENV']
  rails_env_name = defined?(Rails) && Rails.env
  env_name = env_console_name || rails_env_name

  app_name = defined?(Rails) && Rails.application.class.module_parent_name
  folder_name = File.basename(Dir.pwd)
  project_name = (app_name || folder_name).downcase

  prompt_name = [project_name, env_name].compact.join(':')

  helper_type = color_map.fetch(env_name, color_map['fallback'])
  color_helper = Pry::Helpers::Text.method(helper_type)

  config.prompt_name = color_helper.call(prompt_name)
end
