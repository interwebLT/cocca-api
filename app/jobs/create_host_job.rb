class CreateHostJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform record
    execute :post, path: "#{URL}/hosts", body: record
  end
end
