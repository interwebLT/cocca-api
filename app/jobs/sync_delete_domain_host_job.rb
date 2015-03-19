class SyncDeleteDomainHostJob < ActiveJob::Base
  include SyncJob

  queue_as :sync_cocca_records

  def perform record
    execute :delete, path: path(record[:domain], record[:host])
  end

  private

  def path domain, host
    "#{SyncCommonJob::URL}/domains/#{domain}/hosts/#{host}"
  end
end
