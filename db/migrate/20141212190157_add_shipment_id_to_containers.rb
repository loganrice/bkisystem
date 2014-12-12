class AddShipmentIdToContainers < ActiveRecord::Migration
  def change
    add_column :containers, :shipment_id, :integer
  end
end
