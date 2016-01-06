class CreateExcludedIps < ActiveRecord::Migration
  def change
    create_table :excluded_ips do |t|
      t.string  :ip,  null: false,  limit: 16

      t.timestamps null: false
    end
  end
end
