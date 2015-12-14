class AddTransTypeToAuditLedger < ActiveRecord::Migration
  def change
    add_column :audit_ledger, :trans_type, :string, limit: 64
  end
end
