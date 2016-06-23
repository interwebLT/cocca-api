class CreateHostJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/hosts"

  queue_as :sync_cocca_records

  def perform partner, record
    post URL, record, partner: partner
  end
end
