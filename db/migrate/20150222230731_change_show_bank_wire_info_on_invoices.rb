class ChangeShowBankWireInfoOnInvoices < ActiveRecord::Migration
  def up
    change_column :invoices, :show_bank_wire_info, :boolean

  end

  def down
    change_column :invoices, :show_bank_wire_info, :string
  end
end
