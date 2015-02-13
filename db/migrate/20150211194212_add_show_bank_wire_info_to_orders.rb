class AddShowBankWireInfoToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :show_bank_wire_info, :boolean
  end
end
