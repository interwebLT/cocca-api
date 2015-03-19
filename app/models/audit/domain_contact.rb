class Audit::DomainContact < ActiveRecord::Base
  self.table_name = :audit_domain_contact

  attr_accessor :_type_disabled
  self.inheritance_column = :_type_disabled
end
