class RegisterDomainQuery
  def self.run since:, up_to:
    query(since: since, up_to: up_to).to_hash
  end

  private

  def self.query since:, up_to:
    master       = Arel::Table.new(:audit_master)
    ledger       = Arel::Table.new(:audit_ledger)
    domain       = Arel::Table.new(:audit_domain)
    domain_event = Arel::Table.new(:audit_domain_event)

    query = master.project(master[:audit_user].as('partner'),
                           ledger[:currency].as('currency_code'),
                           domain[:name].as('domain'),
                           domain[:authinfopw].as('authcode'),
                           domain_event[:term_length].as('period'),
                           domain[:registrant].as('registrant_handle'),
                           domain[:createdate].as('registered_at'))
      .join(ledger).on(master[:audit_transaction].eq(ledger[:audit_transaction]))
      .join(domain).on(master[:audit_transaction].eq(domain[:audit_transaction]))
      .join(domain_event).on(master[:audit_transaction].eq(domain_event[:audit_transaction]))
      .where(domain[:audit_operation].eq('I'))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))
      .where(master[:audit_user].not_eq('dummy'))

    Audit::Master.connection.select_all query.to_sql
  end
end
