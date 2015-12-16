class CreateContactJob < ActiveJob::Base
  include SyncJob

  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform record
    execute :post, path: "#{URL}/contacts", body: record
  end
end
