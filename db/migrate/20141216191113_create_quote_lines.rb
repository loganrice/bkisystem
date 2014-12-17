class CreateQuoteLines < ActiveRecord::Migration
  def change
    create_table :quote_line_items do |t|
      t.integer :quote_id
      t.integer :item_id
      t.integer :price_cents

      t.timestamps
    end
  end
end
