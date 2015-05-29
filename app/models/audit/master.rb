class Audit::Master < ActiveRecord::Base
  self.table_name = :audit_master
  self.primary_key = :audit_transaction

  def self.latest_time current_time: Time.now
    latest_record = order(audit_time: :desc).first

    latest_record ? latest_record.audit_time : current_time
  end

  def self.transactions since:, up_to:
    self.where(audit_time: since...up_to).where.not(audit_user: ExcludedPartner.all.map(&:name))
  end
end
