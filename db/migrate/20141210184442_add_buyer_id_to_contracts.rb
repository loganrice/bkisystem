class AddBuyerIdToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :buyer_id, :integer
    add_column :contracts, :seller_id, :integer
  end
end
