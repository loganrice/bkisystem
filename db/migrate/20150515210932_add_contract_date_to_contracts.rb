class AddContractDateToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :contract_date, :date
  end
end
