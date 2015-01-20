class CreateOrderDocuments < ActiveRecord::Migration
  def change
    create_table :order_documents do |t|
      t.string :name

      t.timestamps
    end
  end
end
