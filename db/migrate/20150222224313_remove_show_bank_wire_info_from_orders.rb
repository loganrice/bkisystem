class RemoveShowBankWireInfoFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :show_bank_wire_info
  end
end
