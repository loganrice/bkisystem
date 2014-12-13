class RenameShipmentIdToOrderId < ActiveRecord::Migration
  def change
    rename_column :order_details, :shipment_id, :order_id
  end
end
