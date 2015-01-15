class AddShipDateNoteToOrders < ActiveRecord::Migration
  def change
    add_column :orders, :ship_date_note, :string
  end
end
