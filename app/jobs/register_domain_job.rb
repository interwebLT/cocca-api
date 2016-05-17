class RegisterDomainJob < ApplicationJob
  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform partner, record
    json_request = {
      currency_code:  'USD',
      ordered_at:      record[:ordered_at],
      order_details:  [
        {
          type:               'domain_create',
          domain:             record[:domain],
          authcode:           record[:authcode],
          period:             record[:period],
          registrant_handle:  record[:registrant_handle]
        }
      ]
    }

    execute :post, partner: partner, path: "#{URL}/orders", body: json_request
  end
end
