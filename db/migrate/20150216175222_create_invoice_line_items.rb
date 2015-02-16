class CreateInvoiceLineItems < ActiveRecord::Migration
  def change
    create_table :invoice_line_items do |t|
      t.timestamps
      t.integer :amount_cents
      t.integer :order_id
      t.integer :invoice_id
    end
  end
end
