class Audit::DomainHost < ActiveRecord::Base
  include AuditOperation

  self.table_name = :audit_domain_host

  def as_json options = nil
    {
      domain: self.domain_name,
      host:   self.host_name
    }
  end
end
