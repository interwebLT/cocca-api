class Audit::TransferRequest < ActiveRecord::Base
  self.table_name = :audit_transfer_request
  
  SERVER_APPROVED = 'SERVER_APPROVED'
  CLIENT_APPROVED = 'CLIENT_APPROVED'
  PENDING = 'PENDING'

  def period
    self.in_years? ? self.extension_num_units : (self.extension_num_units / 12)
  end

  def in_years?
    self.extension_unit == 'y'
  end
  
  def approved?
    self.response == SERVER_APPROVED or self.response == CLIENT_APPROVED
  end
  
  def incomplete?
    related_transfers = Audit::TransferRequest.where(transfer_request_id: self.transfer_request_id)
    incomplete = true
    related_transfers.each do |transfer|
      incomplete = false if transfer.response != PENDING
    end
    incomplete
  end
  
  def self.last_pending_request domain:
    pending_requests = Audit::TransferRequest.where(domain_name: domain, response: PENDING)
    pending_requests.last
  end

end
