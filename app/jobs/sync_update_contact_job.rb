class SyncUpdateContactJob < ActiveJob::Base
  include SyncJob

  PATH = Rails.configuration.x.registry_url + '/contacts'

  queue_as :sync_cocca_records

  def perform record
    handle = record.delete 'handle'
    record.delete 'partner'
    execute :patch, path: PATH + "/#{handle}", body: record
  end
end
