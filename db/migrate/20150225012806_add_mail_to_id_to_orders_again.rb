class AddMailToIdToOrdersAgain < ActiveRecord::Migration
  def change
    add_column :orders, :mail_to_id, :integer
  end
end
