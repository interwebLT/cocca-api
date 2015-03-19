class SyncUpdateDomainJob < ActiveJob::Base
  include SyncJob

  queue_as :sync_cocca_records

  def perform record
    domain = record.delete(:domain)

    execute :patch, path: path(domain), body: record
  end

  private

  def path domain
    "#{Rails.configuration.x.registry_url}/domains/#{domain}"
  end
end
