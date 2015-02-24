class RemoveSeasonFromOrders < ActiveRecord::Migration
  def change
    remove_column :orders, :season
  end
end
