class RemoveShipDeliveryAndShipPickUpFromContracts < ActiveRecord::Migration
  def change
    remove_column :contracts, :ship_pick_up
    remove_column :contracts, :ship_delivery

  end
end
