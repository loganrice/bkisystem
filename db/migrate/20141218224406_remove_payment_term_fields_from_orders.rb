class RemovePaymentTermFieldsFromOrders < ActiveRecord::Migration
  def change
    # remove_column :order_line_items, :payment_terms
    # commented how due to migration error
    # column "payment_terms" of relation "order_line_items" does not exist
  end
end
