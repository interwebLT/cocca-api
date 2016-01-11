class CreateHostAddressJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform record
    host = record.delete(:host)

    execute :post, path: "#{URL}/hosts/#{host}/addresses", body: record
  end
end
