class UpdateContactJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform partner, record
    handle = record.delete :handle

    execute :patch, partner: partner, path: "#{URL}/contacts/#{handle}", body: record
  end
end
