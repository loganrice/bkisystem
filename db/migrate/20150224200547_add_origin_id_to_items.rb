class AddOriginIdToItems < ActiveRecord::Migration
  def change

    add_column :items, :origin_id, :integer
  end
end
