class UpdateContactJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform record
    json_request = record
    partner = json_request.delete(:partner)

    handle = json_request.delete(:handle)

    execute :patch, partner: partner, path: "#{URL}/contacts/#{handle}", body: json_request
  end
end
