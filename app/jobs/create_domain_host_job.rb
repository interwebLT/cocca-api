class CreateDomainHostJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/domains"

  queue_as :sync_cocca_records

  def perform partner, record
    url = "#{URL}/#{record[:domain]}/hosts"

    body = {
      name: record[:host]
    }

    post url, body, partner: partner
  end
end
