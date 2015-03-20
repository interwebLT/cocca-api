class SyncUpdateContactJob < ActiveJob::Base
  include SyncJob

  queue_as :sync_cocca_records

  def perform record
    handle = record.delete(:handle)
    record.delete(:partner)

    execute :patch, path: path(handle), body: record
  end

  def path handle
    Rails.configuration.x.registry_url + "/contacts/#{handle}"
  end
end
