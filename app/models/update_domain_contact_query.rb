class UpdateDomainContactQuery
  def self.run since:, up_to:
    query(since: since, up_to: up_to).to_hash
  end

  private

  def self.query since:, up_to:
    excluded_partners = Arel::Table.new(:excluded_partners)

    master          = Arel::Table.new(:audit_master)
    domain_contact  = Arel::Table.new(:audit_domain_contact)

    query = master.project(domain_contact[:domain_name].as('domain'),
                           domain_contact[:contact_id].as('handle'),
                           domain_contact[:type].as('type'),
                           domain_contact[:audit_operation].as('audit_operation'))
      .join(domain_contact).on(master[:audit_transaction].eq(domain_contact[:audit_transaction]))
      .where(master[:audit_user].not_in(excluded_partners.project(excluded_partners[:name])))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))
      .order(domain_contact[:audit_operation])

    Audit::Domain.connection.select_all query.to_sql
  end
end
