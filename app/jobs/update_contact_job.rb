class UpdateContactJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/contacts"

  queue_as :sync_cocca_records

  def perform partner, record
    handle  = record.delete :handle
    url     = "#{URL}/#{handle}"

    patch url, record, partner: partner
  end
end
