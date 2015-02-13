class AddRemitFundsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :remit_funds_to, :text
  end
end
