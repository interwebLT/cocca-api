job_type :delayed_rake, 'sleep :delay && cd :path && :environment_variable=:environment bundle exec rake :task --silent :output'

every 1.minute, roles: [:app] do
  rake 'registry:sync'
  delayed_rake 'registry:sync', delay: 15
  delayed_rake 'registry:sync', delay: 30
  delayed_rake 'registry:sync', delay: 45
end
