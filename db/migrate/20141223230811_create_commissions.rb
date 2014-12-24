class CreateCommissions < ActiveRecord::Migration
  def change
    create_table :commissions do |t|
      t.decimal :percent
      t.integer :cents_per_pound
      t.integer :cents
      t.integer :order_id
      t.integer :broker_id

      t.timestamps
    end
  end
end
