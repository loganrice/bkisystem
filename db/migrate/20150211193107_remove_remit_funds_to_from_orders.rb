class RemoveRemitFundsToFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :remit_funds_to
  end
end
