release: bundle exec rake db:migrate
web: bundle exec puma
worker: bundle exec sidekiq --queue default --queue mailers
