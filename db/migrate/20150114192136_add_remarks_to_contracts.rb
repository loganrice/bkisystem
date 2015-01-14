class AddRemarksToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :remarks, :text
  end
end
