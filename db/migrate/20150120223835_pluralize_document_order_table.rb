class PluralizeDocumentOrderTable < ActiveRecord::Migration
  def change
    rename_table :document_order, :document_orders
  end
end
