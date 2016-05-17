class CreateContactJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform record
    execute :post, partner: record[:partner], path: "#{URL}/contacts", body: record
  end
end
