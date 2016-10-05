class Audit::TransferRequest < ActiveRecord::Base
  self.table_name = :audit_transfer_request
  
  SERVER_APPROVED = 'SERVER_APPROVED'
  CLIENT_APPROVED = 'CLIENT_APPROVED'

  def period
    self.in_years? ? self.extension_unit : (self.extension_unit / 12)
  end

  def in_years?
    self.extension_units == 'y'
  end
  
  def approved?
    self.response == SERVER_APPROVED or self.response == CLIENT_APPROVED
  end
end
