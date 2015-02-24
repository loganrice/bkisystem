class AddSeasonToOrderLineItems < ActiveRecord::Migration
  def change
    add_column :orders, :season, :string
  end
end
