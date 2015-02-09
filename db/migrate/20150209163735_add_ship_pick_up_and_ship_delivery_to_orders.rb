class AddShipPickUpAndShipDeliveryToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ship_deliver, :text
    add_column :orders, :ship_pick_up, :text

  end
end
