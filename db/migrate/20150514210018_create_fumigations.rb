class CreateFumigations < ActiveRecord::Migration
  def change
    create_table :fumigations do |t|
      t.string :treatment
      t.string :duration_of_exposure
      t.string :temperature
      t.string :hs_code
      t.date :date_of_treatment
      t.string :concentration
      t.string :permit_number
      t.text :notes

      t.timestamps
      
    end
  end
end
