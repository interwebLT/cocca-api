role :app, %w{deploy@cocca-api.production.local}
role :db,  %w{deploy@cocca-db.production.local}
set :branch, 'production'

role :resque_worker, %w{deploy@cocca-api.production.local}
role :resque_scheduler, %w{deploy@cocca-api.production.local}
