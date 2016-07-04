class CreateContactJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/contacts"

  queue_as :sync_cocca_records

  def perform partner, record
    post URL, record, partner: partner
  end
end
