role :app, %w{deploy@nz.production.local}
role :db,  %w{deploy@nz-db.production.local}
set :branch, 'nz-api'
