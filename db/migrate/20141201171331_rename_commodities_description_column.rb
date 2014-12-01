class RenameCommoditiesDescriptionColumn < ActiveRecord::Migration
  def change
    rename_column :commodities, :description, :name
  end
end
