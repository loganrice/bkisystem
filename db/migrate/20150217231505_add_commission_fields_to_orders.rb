class AddCommissionFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :discount_percent, :decimal
    add_column :orders, :discount_cents_per_pound, :integer
    add_column :orders, :discount_cents, :integer 
  end
end
