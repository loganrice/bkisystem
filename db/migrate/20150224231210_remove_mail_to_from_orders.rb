class RemoveMailToFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :mail_to_id
  end
end
