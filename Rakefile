require_relative 'config/application'
Rails.application.load_tasks

if %w[development test].include? Rails.env
  require 'rubocop/rake_task'
  desc 'Run RuboCop'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.requires << 'rubocop-rails'
  end

  Rake::Task[:default].clear
  task default: %i[rubocop spec]
end
