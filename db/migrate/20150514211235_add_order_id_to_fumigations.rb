class AddOrderIdToFumigations < ActiveRecord::Migration
  def change
    add_column :fumigations, :order_id, :integer
  end
end
