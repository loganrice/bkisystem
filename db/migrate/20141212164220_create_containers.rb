class CreateContainers < ActiveRecord::Migration
  def change
    create_table :containers do |t|
      t.integer :item_id
      t.integer :price_cents
      t.integer :size_indicator_id

      t.timestamps
    end
  end
end
