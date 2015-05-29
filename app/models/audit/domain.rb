class Audit::Domain < ActiveRecord::Base
  self.table_name = :audit_domain

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master

  def domain_contacts
    Audit::DomainContact.where(audit_transaction: self.audit_transaction)
  end
end
