class RemoveWeightGramsFromQuoteLineItems < ActiveRecord::Migration
  def change
    remove_column :quote_line_items, :weight_grams
  end
end
