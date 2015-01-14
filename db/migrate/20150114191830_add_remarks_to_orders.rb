class AddRemarksToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :remarks, :text
  end
end
