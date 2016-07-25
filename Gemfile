source 'https://rubygems.org'

gem 'rails', '4.2.6'

gem 'rails-api'
gem 'pg'
gem 'unicorn'

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'minitest-spec-rails'
  gem 'cucumber-rails',     require: false
  gem 'database_cleaner',   '1.3.0'
  gem 'webmock'
  gem 'factory_girl_rails'
  gem 'timecop'
end

group :development do
  gem 'capistrano'
  gem 'capistrano-rbenv'
  gem 'capistrano-bundler'
  gem 'capistrano-rails'
  gem 'capistrano3-unicorn'
  gem 'capistrano-resque',  require: false
  gem 'capistrano-sidekiq'
end

gem 'exception_notification'
gem 'resque'
gem 'httparty'
gem 'whenever',             require: false
gem 'epp-client',           github: 'dotph/epp-client'
gem 'sidekiq'
