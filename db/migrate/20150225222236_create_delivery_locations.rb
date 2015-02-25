class CreateDeliveryLocations < ActiveRecord::Migration
  def change
    create_table :delivery_locations do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
