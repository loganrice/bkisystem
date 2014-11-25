class AddVarietyIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :variety_id, :integer
  end
end
