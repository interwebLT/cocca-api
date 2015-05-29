class Audit::Master < ActiveRecord::Base
  self.table_name = :audit_master
  self.primary_key = :audit_transaction

  def self.latest_time current_time: Time.now
    latest_record = order(audit_time: :desc).first

    latest_record ? latest_record.audit_time : current_time
  end
end
