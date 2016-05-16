class AddTokenToPartners < ActiveRecord::Migration
  def change
    add_column :partners, :token, :string, null: false, limit: 32
  end
end
