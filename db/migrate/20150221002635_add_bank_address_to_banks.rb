class AddBankAddressToBanks < ActiveRecord::Migration
  def change
    add_column :banks, :line1, :string
    add_column :banks, :line2, :string
    add_column :banks, :line3, :string
    add_column :banks, :city, :string
    add_column :banks, :state, :string
    add_column :banks, :zip, :string
    add_column :banks, :country, :string
  end
end
