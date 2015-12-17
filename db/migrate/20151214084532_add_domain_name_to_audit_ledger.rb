class AddDomainNameToAuditLedger < ActiveRecord::Migration
  def change
    add_column :audit_ledger, :domain_name, :string, limit: 128
  end
end
