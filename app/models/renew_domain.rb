class RenewDomain
  include ActiveModel::Model

  attr_accessor :partner, :currency_code, :domain, :period, :renewed_at

  def self.all since:, up_to:
    query(since: since, up_to: up_to).to_hash.collect {|row| self.new row}
  end

  def self.sync(since:, up_to:)
    all(since: since, up_to: up_to).each do |record|
      SyncRegisterDomainJob.perform_later record.as_json
    end
  end

  def as_json options = nil
    {
      partner: self.partner,
      currency_code: self.currency_code,
      order_details: [
        {
          type: 'domain_renew',
          domain: self.domain,
          period: self.period.to_i,
          renewed_at: self.renewed_at.to_time.utc.iso8601
        }
      ]
    }
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
                           domain_event[:term_length].as('period'),
                           master[:audit_time].as('renewed_at'))
      .join(ledger).on(master[:audit_transaction].eq(ledger[:audit_transaction]))
      .join(domain).on(master[:audit_transaction].eq(domain[:audit_transaction]))
      .join(domain_event).on(master[:audit_transaction].eq(domain_event[:audit_transaction]))
      .where(domain_event[:event].eq('RENEWAL'))
      .where(domain[:audit_operation].eq('U'))
      .where(domain_event[:audit_operation].eq('I'))
      .where(master[:audit_time].gt(since))
      .where(master[:audit_time].lteq(up_to))
      .where(master[:audit_user].not_eq('dummy'))

    Audit::Master.connection.select_all query.to_sql
  end

end
