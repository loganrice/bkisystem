class CreateQuotes < ActiveRecord::Migration
  def change
    create_table :quotes do |t|
      t.integer :seller_id
      t.integer :contract_id

      t.timestamps
    end
  end
end
