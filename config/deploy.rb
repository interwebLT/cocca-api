set :application, 'cocca-api'
set :repo_url, 'git@github.com:dotph/cocca-api.git'
set :branch, ENV['REVISION'] || ENV['BRANCH'] || proc { `git rev-parse --abbrev-ref HEAD`.chomp }.call
set :rails_env, 'production'

set :deploy_to, '/srv/cocca-api'
set :log_level, :info
set :linked_files, %w{config/secrets.yml config/database.yml config/exception_notification.yml config/registry.yml config/resque.yml}
set :linked_dirs, %w{bin log tmp/pids tmp/cache tmp/sockets vendor/bundle public/system}

set :default_env, { path: "$PATH:/usr/pgsql-9.3/bin" }

set :rbenv_type, :user
set :rbenv_ruby, proc { `cat .ruby-version`.chomp }.call
set :rbenv_map_bins, %w{rake gem bundle ruby rails unicorn}

set :bundle_jobs, 4
set :bundle_env_variables, { nokogiri_use_system_libraries: 1 }

set :workers, {
  sync_cocca_records: 1
}

set :resque_log_file, 'log/resque.log'
set :resque_environment_task, true

set :whenever_roles, ->{ :app }

after 'deploy:publishing',  'deploy:restart'
after 'deploy:restart',     'resque:restart'
after 'deploy:updated',     'whenever:update_crontab'
after 'deploy:reverted',    'whenever:update_crontab'

namespace :deploy do
  task :restart do
    invoke 'unicorn:restart'
  end
end
