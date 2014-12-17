class AddWeightGramsToOrderLineItems < ActiveRecord::Migration
  def change
    add_column :order_line_items, :weight_grams, :integer
  end
end
