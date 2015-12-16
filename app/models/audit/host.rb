class Audit::Host < ActiveRecord::Base
  include AuditOperation

  self.table_name = :audit_host

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master

  validates :name, presence: true
  validates :audit_operation, presence: true
  validates :audit_transaction, presence: true

  def as_json options = nil
    {
      partner:  self.master.audit_user,
      name:     self.name
    }
  end
end
