class AddItemSizeIndicatorIdToQuoteLineItems < ActiveRecord::Migration
  def change
    add_column :quote_line_items, :item_size_indicator_id, :integer
  end
end
