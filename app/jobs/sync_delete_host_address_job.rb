class SyncDeleteHostAddressJob < ActiveJob::Base
  include SyncJob

  queue_as :sync_cocca_records

  def perform record
    execute :delete, path: path(record[:host], record[:address])
  end

  private

  def path host, address
    "#{SyncCommonJob::URL}/hosts/#{host}/addresses/#{address}"
  end
end
