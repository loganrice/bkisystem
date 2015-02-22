class AddActingSellerIdToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :acting_seller_id, :integer
  end
end
