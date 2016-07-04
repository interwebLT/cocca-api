class TransferDomainJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/orders"

  queue_as :sync_cocca_records

  def perform partner, record
    body = {
      currency_code:  'USD',
      ordered_at:      record[:ordered_at],
      order_details:  [
        {
          type:               'transfer_domain',
          domain:             record[:domain],
          registrant_handle:  record[:registrant_handle]
        }
      ]
    }

    post URL, body, partner: partner
  end
end
