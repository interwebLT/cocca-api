class Audit::Master < ActiveRecord::Base
  self.table_name = :audit_master
  self.primary_key = :audit_transaction

  has_many :domains,  foreign_key: :audit_transaction, class_name: Audit::Domain
  has_many :contacts, foreign_key: :audit_transaction, class_name: Audit::Contact
  has_many :hosts,    foreign_key: :audit_transaction, class_name: Audit::Host

  def self.latest_time current_time: Time.now
    latest_record = order(audit_time: :desc).first

    (latest_record ? latest_record.audit_time : current_time) + 1.second
  end

  def self.transactions since:, up_to:
    self.where(audit_time: since...up_to)
      .where.not(audit_user: ExcludedPartner.all.map(&:name))
      .where.not(audit_ip: ExcludedIp.all.map(&:ip))
  end
end
