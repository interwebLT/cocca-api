class ContactQuery
  def self.run(since:, up_to:, audit_operation: 'I')
    query(since: since, up_to: up_to, audit_operation: audit_operation).to_hash
  end

  private

  def self.query(since:, up_to:, audit_operation:)
    excluded_partners = Arel::Table.new(:excluded_partners)

    master = Arel::Table.new(:audit_master)
    contact = Arel::Table.new(:audit_contact)

    query = master.project(contact[:clid].as('partner'),
                           contact[:id].as('handle'),
                           contact[:intpostalname].as('name'),
                           contact[:intpostalorg].as('organization'),
                           contact[:intpostalstreet1].as('street'),
                           contact[:intpostalstreet2].as('street2'),
                           contact[:intpostalstreet3].as('street3'),
                           contact[:intpostalcity].as('city'),
                           contact[:intpostalsp].as('state'),
                           contact[:intpostalpc].as('postal_code'),
                           contact[:intpostalcc].as('country_code'),
                           contact[:locpostalname].as('local_name'),
                           contact[:locpostalorg].as('local_organization'),
                           contact[:locpostalstreet1].as('local_street'),
                           contact[:locpostalstreet2].as('local_street2'),
                           contact[:locpostalstreet3].as('local_street3'),
                           contact[:locpostalcity].as('local_city'),
                           contact[:locpostalsp].as('local_state'),
                           contact[:locpostalpc].as('local_postal_code'),
                           contact[:locpostalcc].as('local_country_code'),
                           contact[:voice].as('voice'),
                           contact[:voicex].as('voice_ext'),
                           contact[:fax].as('fax'),
                           contact[:faxx].as('fax_ext'),
                           contact[:email].as('email'))
      .join(contact).on(master[:audit_transaction].eq(contact[:audit_transaction]))
      .where(master[:audit_user].not_in(excluded_partners.project(excluded_partners[:name])))
      .where(contact[:audit_operation].eq(audit_operation))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))
      .where(master[:audit_transaction].not_in(TrId.all.map(&:tr_id)))

    Audit::Master.connection.select_all query.to_sql

  end
end
