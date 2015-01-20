class CreateDocumentsOrders < ActiveRecord::Migration
  def change
    create_table :documents_orders do |t|
      t.integer :document_id
      t.integer :order_id
      t.timestamps 
    end
  end
end
