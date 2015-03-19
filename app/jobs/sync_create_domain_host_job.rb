class SyncCreateDomainHostJob < ActiveJob::Base
  include SyncJob

  queue_as :sync_cocca_records

  def perform record
    domain = record.delete(:domain)

    execute :post, path: path(domain), body: record
  end

  private

  def path domain
    "#{SyncCommonJob::URL}/domains/#{domain}/hosts"
  end
end
