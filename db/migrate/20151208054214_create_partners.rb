class CreatePartners < ActiveRecord::Migration
  def change
    create_table :partners do |t|
      t.string  :name,      limit: 64,  null: false
      t.string  :password,  limit: 255, null: false

      t.timestamps  null: false
    end
  end
end
