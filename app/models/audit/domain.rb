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

  def domain_event
    Audit::DomainEvent.find_by audit_transaction: self.audit_transaction, domain_name: self.name
  end

  def as_json options = nil
    {
      partner:            self.master.audit_user,
      domain:             self.name,
      authcode:           self.authinfopw,
      period:             1,
      registrant_handle:  self.registrant,
      registered_at:      self.createdate.utc.iso8601
    }
  end
end
