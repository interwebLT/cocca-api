class ContactQuery
  def self.run(since:, up_to:, audit_operation: 'I')
    query(since: since, up_to: up_to, audit_operation: audit_operation).to_hash
  end

  private

  def self.query(since:, up_to:, audit_operation:)
    master = Arel::Table.new(:audit_master)
    contact = Arel::Table.new(:audit_contact)

    query = master.project(contact[:clid].as('partner'),
                           contact[:id].as('handle'),
                           contact[:locpostalname].as('name'),
                           contact[:locpostalorg].as('organization'),
                           contact[:locpostalstreet1].as('street'),
                           contact[:locpostalstreet2].as('street2'),
                           contact[:locpostalstreet3].as('street3'),
                           contact[:locpostalcity].as('city'),
                           contact[:locpostalsp].as('state'),
                           contact[:locpostalpc].as('postal_code'),
                           contact[:locpostalcc].as('country_code'),
                           contact[:voice].as('phone'),
                           contact[:email].as('email'))
      .join(contact).on(master[:audit_transaction].eq(contact[:audit_transaction]))
      .where(contact[:audit_operation].eq(audit_operation))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))
      .where(master[:audit_user].not_eq('dummy'))

    Audit::Master.connection.select_all query.to_sql
  end
end
