class AddTermsToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :payment_terms, :text
    add_column :contracts, :ship_pick_up, :text
    add_column :contracts, :ship_delivery, :text
  end
end
