class CreateRegistrySyncHostAddresses < ActiveRecord::Migration
  def change
    create_table :registry_sync_host_addresses do |t|
      t.integer :audit_transaction
      t.string :audit_operation
      t.string :host_name
      t.string :ip
      t.string :address
      t.boolean :queued
      t.boolean :acknowledged
      
      t.datetime :created_at, null: false, default: { expr: "('now'::text)::timestamp" }
      t.datetime :updated_at, null: false, default: { expr: "('now'::text)::timestamp" }
    end
  end
end
