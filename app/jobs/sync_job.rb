class SyncJob < ApplicationJob
  queue_as :queue_cocca_records

  def perform since, up_to
    Sync.sync Audit::Master.transactions(since: Time.at(since), up_to: Time.at(up_to))
  end
end
