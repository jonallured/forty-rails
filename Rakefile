require_relative 'config/application'
Rails.application.load_tasks

if %w[development test].include? Rails.env
  require 'rubocop/rake_task'
  desc 'Run RuboCop'
  RuboCop::RakeTask.new(:rubocop)

  desc 'run prettier diff'
  task :prettier_diff do
    system 'yarn run prettier-diff'
    abort 'prettier-diff failed' unless $CHILD_STATUS.exitstatus.zero?
  end

  desc 'run jest tests'
  task :jest do
    system 'yarn test'
    abort 'jest failed' unless $CHILD_STATUS.exitstatus.zero?
  end

  Rake::Task[:default].clear
  task default: %i[rubocop spec prettier_diff jest]
end
