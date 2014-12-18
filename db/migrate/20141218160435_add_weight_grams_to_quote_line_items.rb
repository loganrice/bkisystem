class AddWeightGramsToQuoteLineItems < ActiveRecord::Migration
  def change
    add_column :quote_line_items, :weight_grams, :integer
  end
end
