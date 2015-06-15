class AddStPendingtransferToAuditDomain < ActiveRecord::Migration
  def change
    add_column :audit_domain, :st_pendingtransfer, :string, limit: 1024
  end
end
