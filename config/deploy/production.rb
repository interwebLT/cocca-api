role :app, %w{deploy@cocca-api.production.local}
role :db,  %w{deploy@cocca-db.production.local}
set :branch, 'production'
