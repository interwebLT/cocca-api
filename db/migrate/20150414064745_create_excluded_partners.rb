class CreateExcludedPartners < ActiveRecord::Migration
  def change
    create_table :excluded_partners do |t|
      t.string :name, null: false,  limit: 64

      t.timestamps null: false
    end
  end
end
