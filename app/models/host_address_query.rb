class HostAddressQuery
  def self.run since:, up_to:, audit_operation:
    query(since: since, up_to: up_to, audit_operation: audit_operation).to_hash
  end

  private

  def self.query since:, up_to:, audit_operation:
    excluded_partners = Arel::Table.new(:excluded_partners)

    master        = Arel::Table.new(:audit_master)
    host_address  = Arel::Table.new(:audit_host_address)

    query = host_address.project(host_address[:host_name].as('host'),
                                 host_address[:address].as('address'),
                                 host_address[:ip].as('type'))
      .join(master).on(host_address[:audit_transaction].eq(master[:audit_transaction]))
      .where(master[:audit_user].not_in(excluded_partners.project(excluded_partners[:name])))
      .where(host_address[:audit_operation].eq(audit_operation))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))

    Audit::HostAddress.connection.select_all query.to_sql
  end
end
