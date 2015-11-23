class SetAuditTransactionLimit < ActiveRecord::Migration
  def change
    change_column :audit_contact,         :audit_transaction, :integer, limit: 8
    change_column :audit_domain,          :audit_transaction, :integer, limit: 8
    change_column :audit_domain_contact,  :audit_transaction, :integer, limit: 8
    change_column :audit_domain_event,    :audit_transaction, :integer, limit: 8
    change_column :audit_domain_host,     :audit_transaction, :integer, limit: 8
    change_column :audit_host,            :audit_transaction, :integer, limit: 8
    change_column :audit_host_address,    :audit_transaction, :integer, limit: 8
    change_column :audit_ledger,          :audit_transaction, :integer, limit: 8
    change_column :audit_master,          :audit_transaction, :integer, limit: 8
  end
end
