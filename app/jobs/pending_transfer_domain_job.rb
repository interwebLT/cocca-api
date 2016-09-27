class PendingTransferDomainJob < ApplicationJob
  URL = "#{Rails.configuration.x.registry_url}/domains"

  queue_as :sync_cocca_records

  def perform partner, record
    url = "#{URL}/#{record[:domain]}"

    body = {
      registrant_handle:          record[:registrant_handle],
      authcode:                   record[:authcode],
      client_hold:                record[:client_hold],
      client_delete_prohibited:   record[:client_delete_prohibited],
      client_renew_prohibited:    record[:client_renew_prohibited],
      client_transfer_prohibited: record[:client_transfer_prohibited],
      client_update_prohibited:   record[:client_update_prohibited],
      server_hold:                record[:server_hold],
      server_delete_prohibited:   record[:server_delete_prohibited],
      server_renew_prohibited:    record[:server_renew_prohibited],
      server_transfer_prohibited: record[:server_transfer_prohibited],
      server_update_prohibited:   record[:server_update_prohibited],
      status_pending_transfer:    record[:status_pending_transfer],
    }

    [:admin_handle, :billing_handle, :tech_handle].each do |handle|
      body[handle] = record[handle] if record.has_key? handle
    end

    patch url, body, partner: partner
  end
end
