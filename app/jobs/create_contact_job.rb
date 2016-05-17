class CreateContactJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform partner, record
    execute :post, partner: partner, path: "#{URL}/contacts", body: record
  end
end
