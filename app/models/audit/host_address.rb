class Audit::HostAddress < ActiveRecord::Base
  self.table_name = :audit_host_address

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master
end
