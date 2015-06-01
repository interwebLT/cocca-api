class RegisterDomainJob < ActiveJob::Base
  include SyncJob

  URL = Rails.configuration.x.registry_url

  queue_as :sync_cocca_records

  def perform record
    json_request = {
      partner:        record[:partner],
      currency_code:  'USD',
      order_details:  [
        {
          type:               'domain_create',
          domain:             record[:domain],
          authcode:           record[:authcode],
          period:             record[:period],
          registrant_handle:  record[:registrant_handle],
          registered_at:      record[:registered_at]
        }
      ]
    }

    execute :post, path: "#{URL}/orders", body: json_request

    record[:domain_hosts].each do |domain_host|
      case domain_host[:audit_operation]
      when AuditOperation::INSERT_OPERATION
        json_request = {
          name: domain_host[:host]
        }

        execute :post, path: "#{URL}/domains/#{record[:domain]}/hosts", body: json_request
      when AuditOperation::DELETE_OPERATION
        execute :delete, path: "#{URL}/domains/#{record[:domain]}/hosts/#{domain_host[:host]}"
      end
    end
  end
end
