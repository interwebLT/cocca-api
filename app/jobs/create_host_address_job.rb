class CreateHostAddressJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/hosts"

  queue_as :sync_cocca_records

  def perform partner, record
    host  = record.delete :host
    url   = "#{URL}/#{host}/addresses"

    post url, record, partner: partner
  end
end
