class AddAuthinfopwToAuditDomain < ActiveRecord::Migration
  def change
    add_column :audit_domain, :authinfopw, :string, limit: 64
  end
end
