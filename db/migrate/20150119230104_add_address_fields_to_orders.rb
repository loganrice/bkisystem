class AddAddressFieldsToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :line1, :string
    add_column :orders, :line2, :string
    add_column :orders, :line3, :string
    add_column :orders, :city, :string
    add_column :orders, :state, :string
    add_column :orders, :zip, :string
    add_column :orders, :country, :string
  end
end
