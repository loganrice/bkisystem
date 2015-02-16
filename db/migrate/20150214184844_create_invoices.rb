class CreateInvoices < ActiveRecord::Migration
  def change
    create_table :invoices do |t|
      t.integer :order_id
      t.integer :payee_id
      t.integer :payer_id
      t.integer :address_id
      t.integer :bank_id

      t.timestamps
    end
  end
end
