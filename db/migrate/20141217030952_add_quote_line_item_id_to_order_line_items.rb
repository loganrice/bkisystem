class AddQuoteLineItemIdToOrderLineItems < ActiveRecord::Migration
  def change
    add_column :order_line_items, :quote_line_item_id, :integer
  end
end
