class ItemSizeIndicators < ActiveRecord::Migration
  def change
    create_table :item_size_indicators do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
