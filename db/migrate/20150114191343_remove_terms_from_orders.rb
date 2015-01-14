class RemoveTermsFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :payment_terms 
    remove_column :orders, :remarks
    remove_column :orders, :ship_delivery
    remove_column :orders, :ship_pick_up
  end
end
