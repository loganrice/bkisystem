class ChangeWeightGramsTypeInQuoteLineItems < ActiveRecord::Migration
  def change
    change_column :quote_line_items, :pack_weight_grams, :decimal, precision: 16, scale: 2
  end

end
