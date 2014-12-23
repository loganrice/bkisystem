class AddItemSizeIndicatorIdToOrderLineItems < ActiveRecord::Migration
  def change
    add_column :order_line_items, :item_size_indicator_id, :integer

  end
end
