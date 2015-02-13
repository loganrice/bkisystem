class AddActingSellerIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :acting_seller_id, :integer
  end
end
