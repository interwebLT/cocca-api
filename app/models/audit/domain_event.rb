class Audit::DomainEvent < ActiveRecord::Base
  self.table_name = :audit_domain_event
end
