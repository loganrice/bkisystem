class AddBankIdToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :bank_id, :integer
  end
end
