class HostQuery
  def self.run since:, up_to:
    query(since: since, up_to: up_to).to_hash
  end

  private

  def self.query since:, up_to:
    host    = Arel::Table.new(:audit_host)
    master  = Arel::Table.new(:audit_master)

    query = host.project(master[:audit_user].as('partner'),
                         host[:name].as('name'))
      .join(master).on(host[:audit_transaction].eq(master[:audit_transaction]))
      .where(host[:audit_operation].eq('I'))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))
      .where(master[:audit_user].not_eq('dummy'))

    Audit::Host.connection.select_all query.to_sql
  end
end
