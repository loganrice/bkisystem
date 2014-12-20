class AddGradeIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :grade_id, :integer
  end
end
