class RenewDomainJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/orders"

  queue_as :sync_cocca_records

  def perform partner, record
    body = {
      currency_code:  'USD',
      ordered_at:     record[:ordered_at],
      order_details:  [
        {
          type:  'domain_renew',
          domain: record[:domain],
          period: record[:period]
        }
      ]
    }

    post URL, body, partner: partner
  end
end
