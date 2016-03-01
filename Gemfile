source 'https://rubygems.org'

gem 'rails', '4.2.5.1'

gem 'rails-api'

gem 'spring', group: :development

gem 'pg'

# To use ActiveModel has_secure_password
# gem 'bcrypt-ruby', '~> 3.1.2'

# To use Jbuilder templates for JSON
# gem 'jbuilder'

# Use unicorn as the app server
gem 'unicorn'

# Deploy with Capistrano
# gem 'capistrano', :group => :development

# To use debugger
# gem 'ruby-debug19', :require => 'ruby-debug'

group :development, :test do
  gem 'rspec-rails'
end

group :test do
  gem 'minitest-spec-rails'
  gem 'cucumber-rails', require: false
  gem 'database_cleaner', '1.3.0'
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
  gem 'capistrano-resque', require: false
end

gem 'exception_notification'
gem 'resque'
gem 'httparty'
gem 'whenever', require: false
gem 'epp-client'
