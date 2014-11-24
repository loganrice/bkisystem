class CreateVariety < ActiveRecord::Migration
  def change
    create_table :varieties do |t|
      t.string :name
      t.timestamps
    end
  end
end
