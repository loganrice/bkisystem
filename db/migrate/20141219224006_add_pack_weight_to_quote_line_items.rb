class AddPackWeightToQuoteLineItems < ActiveRecord::Migration
  def change
    add_column :quote_line_items, :pack_weight_grams, :integer
    add_column :quote_line_items, :pack_type_id, :integer
    add_column :quote_line_items, :weight_id, :integer 
  end
end
