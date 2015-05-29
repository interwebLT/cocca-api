class Audit::Domain < ActiveRecord::Base
  self.table_name = :audit_domain

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master

  def domain_contacts
    records = Audit::DomainContact.where(audit_transaction: self.audit_transaction)

    result = {}

    records.each do |record|
      key = { handle: record.contact_id, type: record.type }

      if result.has_key? key
        result.delete key
      else
        result[key] = record
      end
    end

    result.values
  end
end
