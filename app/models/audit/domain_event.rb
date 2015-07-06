class Audit::DomainEvent < ActiveRecord::Base
  self.table_name = :audit_domain_event

  def period
    self.in_years? ? self.term_length : (self.term_length / 12)
  end

  def in_years?
    self.term_units == 'YEAR'
  end
end
