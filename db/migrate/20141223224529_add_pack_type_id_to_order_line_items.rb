class AddPackTypeIdToOrderLineItems < ActiveRecord::Migration
  def change
    add_column :order_line_items, :pack_type_id, :integer
  end
end
