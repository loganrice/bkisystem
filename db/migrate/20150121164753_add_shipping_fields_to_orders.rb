class AddShippingFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :container_number, :string
    add_column :orders, :seal_number, :string
    add_column :orders, :gross_weight, :string
    add_column :orders, :container_out, :date
    add_column :orders, :docs_in, :date
    add_column :orders, :docs_out, :date
    add_column :orders, :invoice_number, :string
    add_column :orders, :expected_pay, :date
    add_column :orders, :received_pay, :date
    add_column :orders, :amount_received, :string
  end
end
