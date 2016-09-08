class CreateRegistrySyncMasters < ActiveRecord::Migration
  def change
    create_table :registry_sync_masters do |t|
      t.integer :audit_transaction
      t.string :audit_user
      t.string :audit_login
      t.timestamp :audit_time
      t.string :audit_ip
      t.boolean :queued
      t.boolean :acknowledged

      t.datetime :created_at, null: false, default: { expr: "('now'::text)::timestamp" }
      t.datetime :updated_at, null: false, default: { expr: "('now'::text)::timestamp" }
    end
  end
end
