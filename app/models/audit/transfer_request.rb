class Audit::TransferRequest < ActiveRecord::Base
  self.table_name = :audit_transfer_request
  
  SERVER_APPROVED = 'SERVER_APPROVED'
  CLIENT_APPROVED = 'CLIENT_APPROVED'

  def period
    self.in_years? ? self.extension_num_units : (self.extension_num_units / 12)
  end

  def in_years?
    self.extension_unit == 'y'
  end
  
  def approved?
    self.response == SERVER_APPROVED or self.response == CLIENT_APPROVED
  end
end
