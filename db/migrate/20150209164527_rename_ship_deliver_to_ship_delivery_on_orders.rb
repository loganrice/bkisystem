class RenameShipDeliverToShipDeliveryOnOrders < ActiveRecord::Migration
  def change
    rename_column :orders, :ship_deliver, :ship_delivery
  end
end
