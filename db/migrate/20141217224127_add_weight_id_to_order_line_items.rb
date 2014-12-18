class AddWeightIdToOrderLineItems < ActiveRecord::Migration
  def change
    add_column :order_line_items, :weight_id, :integer
  end
end
