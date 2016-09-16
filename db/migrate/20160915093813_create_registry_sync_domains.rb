class CreateRegistrySyncDomains < ActiveRecord::Migration
  def change
    create_table :registry_sync_domains do |t|
      t.integer :audit_transaction
      t.string :audit_operation
      t.string :roid
      t.string :name
      t.timestamp :exdate
      t.text :st_cl_deleteprohibited
      t.text :st_cl_hold
      t.text :st_cl_renewprohibited
      t.text :st_cl_transferprohibited      
      t.text :st_cl_updateprohibited
      t.text :st_inactive
      t.text :st_ok
      t.text :st_pendingcreate
      t.text :st_pendingdelete
      t.text :st_pendingrenew
      t.text :st_pendingtransfer
      t.text :st_pendingupdate
      t.text :st_sv_deleteprohibited
      t.text :st_sv_hold
      t.text :st_sv_renewprohibited
      t.text :st_sv_transferprohibited
      t.text :st_sv_updateprohibited
      t.string :registrant
      t.string :authinfopw
      t.string :clid
      t.string :crid
      t.timestamp :createdate
      t.string :upid
      t.timestamp :updatedate
      t.string :zone
      t.timestamp :deletedate
      t.boolean :queued
      t.boolean :acknowledged
      
      t.datetime :created_at, null: false, default: { expr: "('now'::text)::timestamp" }
      t.datetime :updated_at, null: false, default: { expr: "('now'::text)::timestamp" }
    end
  end
end
