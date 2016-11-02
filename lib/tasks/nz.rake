namespace :nz do
  desc "Test EPP Domain Check"
  task check: :environment do
    NzTester.check
  end
end