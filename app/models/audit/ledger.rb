class Audit::Ledger < ActiveRecord::Base
  self.table_name = :audit_ledger

  TRANSFER = 'Transfer'

  def transfer?
    self.trans_type == TRANSFER
  end
end
