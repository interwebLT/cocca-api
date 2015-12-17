class Audit::HostAddress < ActiveRecord::Base
  include AuditOperation

  self.table_name = :audit_host_address

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master

  def as_json options = nil
    {
      host:     self.host_name,
      address:  self.address,
      type:     self.ip
    }
  end
end
