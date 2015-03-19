class SyncCreateHostAddressJob < ActiveJob::Base
  include SyncJob

  queue_as :sync_cocca_records

  def perform record
    host = record.delete(:host)

    execute :post, path: path(host), body: record
  end

  private

  def path host
    "#{SyncCommonJob::URL}/hosts/#{host}/addresses"
  end
end
