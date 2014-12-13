class ChangeShipmentsToOrders < ActiveRecord::Migration
  def change
    rename_table :shipments, :orders
  end
end
