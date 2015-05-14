class AddGrossTruckWeightToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :gross_truck_weight, :string
  end
end
