class CreateRegistrySyncContacts < ActiveRecord::Migration
  def change
    create_table :registry_sync_contacts do |t|
      t.integer :audit_transaction
      t.string :audit_operation
      t.string :roid
      t.string :audit_contactid
      t.timestamp :exdate
      t.text :st_cl_deleteprohibited
      t.text :st_cl_transferprohibited      
      t.text :st_cl_updateprohibited
      t.text :st_linked
      t.text :st_ok
      t.text :st_pendingcreate
      t.text :st_pendingdelete
      t.text :st_pendingtransfer
      t.text :st_pendingupdate
      t.text :st_sv_deleteprohibited
      t.text :st_sv_transferprohibited
      t.text :st_sv_updateprohibited
      t.string :intpostalname
      t.string :intpostalorg
      t.string :intpostalstreet1
      t.string :intpostalstreet2
      t.string :intpostalstreet3
      t.string :intpostalcity
      t.string :intpostalsp
      t.string :intpostalpc
      t.string :intpostalcc
      t.string :locpostalname
      t.string :locpostalorg
      t.string :locpostalstreet1
      t.string :locpostalstreet2
      t.string :locpostalstreet3
      t.string :locpostalcity
      t.string :locpostalsp
      t.string :locpostalpc
      t.string :locpostalcc
      t.string :voice
      t.string :voicex
      t.string :fax
      t.string :faxx
      t.text :email
      t.string :authinfopw
      t.string :clid
      t.string :crid
      t.timestamp :createdate
      t.string :upid
      t.timestamp :updatedate
      t.timestamp :transferdate
      t.boolean :queued
      t.boolean :acknowledged

      t.datetime :created_at, null: false, default: { expr: "('now'::text)::timestamp" }
      t.datetime :updated_at, null: false, default: { expr: "('now'::text)::timestamp" }
    end
  end
end
