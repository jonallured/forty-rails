require_relative 'config/application'
Rails.application.load_tasks

if %w[development test].include? Rails.env
  require 'rubocop/rake_task'
  desc 'Run RuboCop'
  RuboCop::RakeTask.new(:rubocop) do |task|
    task.requires << 'rubocop-rails'
  end

  desc 'run prettier check'
  task :prettier_check do
    system 'yarn run prettier-check'
    abort 'prettier-check failed' unless $CHILD_STATUS.exitstatus.zero?
  end

  Rake::Task[:default].clear
  task default: %i[prettier_check rubocop spec]
end
