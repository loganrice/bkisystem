class RenameContainersToOrderDetails < ActiveRecord::Migration
  def change
    rename_table :containers, :order_details
  end
end
