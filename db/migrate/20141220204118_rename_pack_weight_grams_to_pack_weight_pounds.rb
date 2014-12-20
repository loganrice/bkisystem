class RenamePackWeightGramsToPackWeightPounds < ActiveRecord::Migration
  def change
    rename_column :quote_line_items, :pack_weight_grams, :pack_weight_pounds
  end
end
