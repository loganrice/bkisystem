class CreateWeights < ActiveRecord::Migration
  def change
    create_table :weights do |t|
      t.string :weight_unit_of_measure

      t.timestamps
    end
  end
end
