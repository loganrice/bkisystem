class AddLoadNumberToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :load_number, :integer
  end
end
