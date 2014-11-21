class AddCommodityIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :commodity_id, :integer
  end
end
