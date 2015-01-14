class RemoveRemarksFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :remarks
  end
end
