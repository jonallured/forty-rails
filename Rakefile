require_relative 'config/application'
Rails.application.load_tasks

if %w[development test].include? Rails.env
  desc 'run prettier diff'
  task :prettier do
    system 'yarn run prettier-diff'
    abort 'prettier-diff failed' unless $CHILD_STATUS.exitstatus.zero?
  end

  desc 'run type checks'
  task :tsc do
    system 'yarn type-check'
    abort 'type checks failed' unless $CHILD_STATUS.exitstatus.zero?
  end

  desc 'run jest tests'
  task :jest do
    system 'yarn test --reporters="jest-simple-dot-reporter"'
    abort 'jest failed' unless $CHILD_STATUS.exitstatus.zero?
  end

  require 'rubocop/rake_task'
  desc 'Run RuboCop'
  RuboCop::RakeTask.new(:rubocop)

  if defined? RSpec
    task(:spec).clear
    RSpec::Core::RakeTask.new(:spec) do |t|
      t.verbose = false
    end
  end

  Rake::Task[:default].clear
  task default: %i[prettier tsc jest rubocop spec]
end
