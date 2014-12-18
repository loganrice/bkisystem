class RemovePaymentTermFieldsFromOrders < ActiveRecord::Migration
  def change
    remove_column :order_line_items, :payment_terms
  end
end
