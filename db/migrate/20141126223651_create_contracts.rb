class CreateContracts < ActiveRecord::Migration
  def change
    create_table :contracts do |t|
      t.string :buyer_contract
      t.string :buyer_po
      t.string :seller_contract
      t.date :date
      t.timestamps
    end
  end
end
