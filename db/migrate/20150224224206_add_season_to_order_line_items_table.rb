class AddSeasonToOrderLineItemsTable < ActiveRecord::Migration
  def change
    add_column :order_line_items, :season, :string
  end
end
