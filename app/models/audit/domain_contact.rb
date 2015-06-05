class Audit::DomainContact < ActiveRecord::Base
  include AuditOperation

  self.table_name = :audit_domain_contact

  ADMIN_TYPE    = 'admin'
  BILLING_TYPE  = 'billing'
  TECH_TYPE     = 'tech'

  attr_accessor :_type_disabled
  self.inheritance_column = :_type_disabled

  def admin_contact?
    self.type == ADMIN_TYPE
  end

  def billing_contact?
    self.type == BILLING_TYPE
  end

  def tech_contact?
    self.type == TECH_TYPE
  end
end
