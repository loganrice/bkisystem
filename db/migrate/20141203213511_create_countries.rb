class CreateCountries < ActiveRecord::Migration
  def change
    create_table :countries do |t|
      t.integer :geoname_id
      t.string :continent_code
      t.string :continent_name
      t.string :country_iso_code
      t.string :country_name
      t.string :subdivision_iso_code
      t.string :subdivision_name
      t.string :city_name
      t.integer :metro_code
      t.string :time_zone

      t.timestamps
    end
  end
end
