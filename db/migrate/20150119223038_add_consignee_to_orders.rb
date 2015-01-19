class AddConsigneeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :consignee, :string
  end
end
