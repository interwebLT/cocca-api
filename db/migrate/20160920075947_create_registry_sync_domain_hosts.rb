class CreateRegistrySyncDomainHosts < ActiveRecord::Migration
  def change
    create_table :registry_sync_domain_hosts do |t|
      t.integer :audit_transaction
      t.string :audit_operation
      t.string :domain_name
      t.string :host_name
      t.integer :sort_order
      t.boolean :queued
      t.boolean :acknowledged
      
      t.datetime :created_at, null: false, default: { expr: "('now'::text)::timestamp" }
      t.datetime :updated_at, null: false, default: { expr: "('now'::text)::timestamp" }
    end
  end
end
