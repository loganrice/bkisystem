class AddShipDateNoteToContracts < ActiveRecord::Migration
  def change
    add_column :contracts, :ship_date_note, :string
  end
end
