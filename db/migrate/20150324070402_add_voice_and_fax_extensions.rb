class AddVoiceAndFaxExtensions < ActiveRecord::Migration
  def change
    add_column :audit_contact, :voicex, :string, limit: 64
    add_column :audit_contact, :faxx,   :string, limit: 64
  end
end
