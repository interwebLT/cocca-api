class Audit::Ledger < ActiveRecord::Base
  self.table_name = :audit_ledger

  TRANSFER = 'Transfer'
  RENEW = 'Renewal'
  REGISTER = 'Registration'

  def transfer?
    trans_type == TRANSFER
  end

  def renew?
    trans_type == RENEW
  end

  def register?
    trans_type == REGISTER
  end
end
