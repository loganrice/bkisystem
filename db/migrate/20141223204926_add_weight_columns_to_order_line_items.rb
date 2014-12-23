class AddWeightColumnsToOrderLineItems < ActiveRecord::Migration
  def change
    add_column :order_line_items, :pack_weight_pounds, :decimal
    remove_column :order_line_items, :weight_grams
    add_column :order_line_items, :pack_count, :integer
    remove_column :order_line_items, :size_indicator_id

  end
end
