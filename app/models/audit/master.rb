class Audit::Master < ActiveRecord::Base
  self.table_name = :audit_master

  def self.latest_time current_time: Time.now
    latest_record = order(audit_time: :desc).first

    latest_record ? latest_record.audit_time : current_time
  end
end
