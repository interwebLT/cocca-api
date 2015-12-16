class Audit::Contact < ActiveRecord::Base
  self.table_name = :audit_contact

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master
end

