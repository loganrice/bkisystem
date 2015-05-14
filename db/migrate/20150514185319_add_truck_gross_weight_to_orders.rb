class AddTruckGrossWeightToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :truck_gross_weight, :string
  end
end
