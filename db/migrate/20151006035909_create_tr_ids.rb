class CreateTrIds < ActiveRecord::Migration
  def change
    create_table :tr_ids do |t|
      t.string :tr_id
      t.timestamp :transaction_date

      t.timestamps null: false
    end
  end
end
