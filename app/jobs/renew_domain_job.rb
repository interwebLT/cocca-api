class RenewDomainJob < ActiveJob::Base
  include SyncJob

  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform record
    json_request = {
      partner:        record[:partner],
      currency_code:  'USD',
      ordered_at:     record[:renewed_at],
      order_details:  [
        {
          type:      'domain_renew',
          domain:     record[:domain],
          period:     record[:period],
          renewed_at: record[:renewed_at]
        }
      ]
    }

    execute :post, path: "#{URL}/orders", body: json_request
  end
end
