class Audit::Host < ActiveRecord::Base
  self.table_name = :audit_host

  validates :name, presence: true
  validates :audit_operation, presence: true
  validates :audit_transaction, presence: true
end
