class AddContainerSizeToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :container_size, :string
  end
end
