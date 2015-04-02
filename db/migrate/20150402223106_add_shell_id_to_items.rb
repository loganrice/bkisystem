class AddShellIdToItems < ActiveRecord::Migration
  def change
    add_column :items, :shell_id, :integer
  end
end
