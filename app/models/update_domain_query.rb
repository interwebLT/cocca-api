class UpdateDomainQuery
  STATUS_MAP = {
    client_hold_status:     :client_hold,
    client_delete_status:   :client_delete_prohibited,
    client_renew_status:    :client_renew_prohibited,
    client_transfer_status: :client_transfer_prohibited,
    client_update_status:   :client_update_prohibited
  }

  def self.run since:, up_to:
    query(since: since, up_to: up_to).to_hash.collect do |h|
      STATUS_MAP.each do |k, v|
        status = h.delete(k.to_s)

        h[v.to_s] = !status.nil?
      end

      h
    end
  end

  private

  def self.query since:, up_to:
    excluded_partners = Arel::Table.new(:excluded_partners)

    master = Arel::Table.new(:audit_master)
    domain = Arel::Table.new(:audit_domain)

    query = domain.project(domain[:name].as('domain'),
                           domain[:registrant].as('registrant'),
                           domain[:authinfopw].as('authcode'),
                           domain[:st_cl_deleteprohibited].as('client_delete_status'),
                           domain[:st_cl_hold].as('client_hold_status'),
                           domain[:st_cl_renewprohibited].as('client_renew_status'),
                           domain[:st_cl_transferprohibited].as('client_transfer_status'),
                           domain[:st_cl_updateprohibited].as('client_update_status'))
      .join(master).on(domain[:audit_transaction].eq(master[:audit_transaction]))
      .where(master[:audit_user].not_in(excluded_partners.project(excluded_partners[:name])))
      .where(domain[:audit_operation].eq('U'))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))

    Audit::Domain.connection.select_all query.to_sql
  end
end
