role :app, %w{deploy@cocca-api.production.local}
set :branch, 'production'

role :resque_worker, %w{deploy@cocca-api.production.local}
role :resque_scheduler, %w{deploy@cocca-api.production.local}
