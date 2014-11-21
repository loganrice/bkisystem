class AddSizeIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :size_id, :integer
  end
end
