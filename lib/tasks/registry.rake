namespace :registry do
  desc "Continues pushing to registry new domain registrations and from error queue"
  task sync: :environment do
    Sync.run
  end
end
