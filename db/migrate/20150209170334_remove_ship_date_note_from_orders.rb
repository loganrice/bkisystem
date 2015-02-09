class RemoveShipDateNoteFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :ship_date_note
  end
end
