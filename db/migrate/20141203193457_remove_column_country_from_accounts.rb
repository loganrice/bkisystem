class RemoveColumnCountryFromAccounts < ActiveRecord::Migration
  def change
    remove_column :accounts, :country, :string
  end
end
