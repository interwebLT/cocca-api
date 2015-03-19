class DomainHostQuery
  def self.run since:, up_to:, audit_operation:
    query(since: since, up_to: up_to, audit_operation: audit_operation).to_hash
  end

  private

  def self.query since:, up_to:, audit_operation:
    master      = Arel::Table.new(:audit_master)
    domain_host = Arel::Table.new(:audit_domain_host)

    query = domain_host.project(master[:audit_user].as('partner'),
                                domain_host[:domain_name].as('domain'),
                                domain_host[:host_name].as('host'))
      .join(master).on(domain_host[:audit_transaction].eq(master[:audit_transaction]))
      .where(domain_host[:audit_operation].eq(audit_operation))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))
      .where(master[:audit_user].not_eq('dummy'))

    Audit::DomainHost.connection.select_all query.to_sql
  end
end
