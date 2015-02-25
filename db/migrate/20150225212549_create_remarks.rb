class CreateRemarks < ActiveRecord::Migration
  def change
    create_table :remarks do |t|
      t.string :name
      t.text :description
      t.timestamps
    end
  end
end
