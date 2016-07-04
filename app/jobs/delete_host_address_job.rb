class DeleteHostAddressJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform partner, record
    delete "#{URL}/hosts/#{record[:host]}/addresses/#{record[:address]}", partner: partner
  end
end
