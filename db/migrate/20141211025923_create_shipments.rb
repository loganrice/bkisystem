class CreateShipments < ActiveRecord::Migration
  def change
    create_table :shipments do |t|
      t.date :ship_date
      t.date :last_received_date
      t.date :doc_cut_off
      t.date :estimated_arrival_date
      t.string :shipping_company
      t.string :voyage
      t.string :port_of_discharge
      t.string :vessel
      t.string :ship_in_name_of
      t.string :booking_number
      t.string :commodity
      t.string :shipping_company_reference_number
      t.string :automated_export_number
      t.text :payment_terms
      t.text :remarks
      t.text :ship_pick_up
      t.text :ship_delivery
      t.timestamps
    end
  end
end
