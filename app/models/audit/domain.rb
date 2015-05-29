class Audit::Domain < ActiveRecord::Base
  self.table_name = :audit_domain

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master
end
