class AddHideCommissionToInvoices < ActiveRecord::Migration
  def change
    add_column :invoices, :hide_commission, :boolean
  end
end
