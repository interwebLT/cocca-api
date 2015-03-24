class AddStreetsToAuditContact < ActiveRecord::Migration
  def change
    add_column :audit_contact, :intpostalstreet2, :string, limit: 255
    add_column :audit_contact, :intpostalstreet3, :string, limit: 255

    add_column :audit_contact, :locpostalstreet2, :string, limit: 255
    add_column :audit_contact, :locpostalstreet3, :string, limit: 255
  end
end
