class Audit::Domain < ActiveRecord::Base
  include AuditOperation

  self.table_name = :audit_domain

  belongs_to :master, foreign_key: :audit_transaction, class_name: Audit::Master

  alias_attribute :txn, :audit_transaction

  def domain_contacts
    params = { audit_transaction: self.audit_transaction, domain_name: self.name }

    records = Audit::DomainContact.where(params).order(:audit_operation)

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

  def domain_hosts
    params = { audit_transaction: self.audit_transaction, domain_name: self.name }

    records = Audit::DomainHost.where(params).order(:audit_operation)

    result = {}

    records.each do |record|
      key = record.host_name

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

  def ledger
    Audit::Ledger.find_by audit_transaction: self.audit_transaction, domain_name: self.name
  end

  def register_domain?
    self.insert_operation?
  end

  def update_domain?
    update_operation? and ledger.nil?
  end

  def renew_domain?
    update_operation? and ledger.present? and ledger.renew?
  end

  def transfer_domain?
    update_operation? and ledger.present? and ledger.transfer? and (ledger.client_roid == clid)
  end

  def as_json options = nil
    result = {
      partner:                    self.clid,
      domain:                     self.name,
      authcode:                   self.authinfopw,
      period:                     (self.domain_event.period if self.domain_event),
      registrant_handle:          self.registrant,
      ordered_at:                 self.master.audit_time.utc.iso8601,
      client_hold:                !self.st_cl_hold.blank?,
      client_delete_prohibited:   !self.st_cl_deleteprohibited.blank?,
      client_renew_prohibited:    !self.st_cl_renewprohibited.blank?,
      client_transfer_prohibited: !self.st_cl_transferprohibited.blank?,
      client_update_prohibited:   !self.st_cl_updateprohibited.blank?,
      server_hold:                !self.st_sv_hold.blank?,
      server_delete_prohibited:   !self.st_sv_deleteprohibited.blank?,
      server_renew_prohibited:    !self.st_sv_renewprohibited.blank?,
      server_transfer_prohibited: !self.st_sv_transferprohibited.blank?,
      server_update_prohibited:   !self.st_sv_updateprohibited.blank?,
      domain_hosts:               []
    }

    self.domain_contacts.each do |domain_contact|
      handle = domain_contact.insert_operation? ? domain_contact.contact_id : nil

      (result[:admin_handle]    = handle) if domain_contact.admin_contact?
      (result[:billing_handle]  = handle) if domain_contact.billing_contact?
      (result[:tech_handle]     = handle) if domain_contact.tech_contact?
    end

    self.domain_hosts.each do |domain_host|
      result[:domain_hosts] << {
        audit_operation:  domain_host.audit_operation,
        host:             domain_host.host_name
      }
    end

    result
  end
end
