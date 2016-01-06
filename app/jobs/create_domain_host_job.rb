class CreateDomainHostJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform record
    path = "#{URL}/domains/#{record[:domain]}/hosts"

    json_request = {
      name: record[:host]
    }

    execute :post, path: path, body: json_request
  end
end
