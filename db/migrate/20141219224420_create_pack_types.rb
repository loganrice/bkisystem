class CreatePackTypes < ActiveRecord::Migration
  def change
    create_table :pack_types do |t|
      t.string :name
      
      t.timestamps
    end
  end
end
