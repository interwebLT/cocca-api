role :app, %w{deploy@nz.staging.local}
role :db,  %w{deploy@nz-db.staging.local}
set :branch, 'nz-api'
