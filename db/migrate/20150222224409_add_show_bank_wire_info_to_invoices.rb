class AddShowBankWireInfoToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :show_bank_wire_info, :string
  end
end
