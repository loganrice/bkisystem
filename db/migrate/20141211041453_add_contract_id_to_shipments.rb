class AddContractIdToShipments < ActiveRecord::Migration
  def change
    add_column :shipments, :contract_id, :integer
  end
end
