class CreateCertificiateOrOrigins < ActiveRecord::Migration
  def change
    create_table :certificiate_or_origins do |t|
      t.string :hs_code
      t.string :treatment
      t.string :place_of_initial_receipt
      t.string :port_of_loading
      t.string :forwarding_agent
      t.string :initial_carriage_by
      t.string :vessel
      t.text :port_of_loading

      t.timestamps
    end
  end
end
