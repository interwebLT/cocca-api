class DeleteDomainHostJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/domains"

  queue_as :sync_cocca_records

  def perform partner, record
    delete "#{URL}/#{record[:domain]}/hosts/#{record[:host]}", partner: partner
  end
end
