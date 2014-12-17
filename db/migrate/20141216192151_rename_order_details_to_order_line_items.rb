class RenameOrderDetailsToOrderLineItems < ActiveRecord::Migration
  def change
    rename_table :order_details, :order_line_items
  end
end
