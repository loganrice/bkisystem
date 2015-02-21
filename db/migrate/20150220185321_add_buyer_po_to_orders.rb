class AddBuyerPoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :buyer_po, :string
  end
end
