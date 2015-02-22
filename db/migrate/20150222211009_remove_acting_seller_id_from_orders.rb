class RemoveActingSellerIdFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :acting_seller_id
  end
end
