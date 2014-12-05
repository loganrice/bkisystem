class AddAccountIdToBanks < ActiveRecord::Migration
  def change
    add_column :banks, :account_id, :integer
  end
end
