class AddShippingInstructionsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :shipping_instructions, :text
  end
end
