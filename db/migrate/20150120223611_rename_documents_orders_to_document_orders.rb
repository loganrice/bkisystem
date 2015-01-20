class RenameDocumentsOrdersToDocumentOrders < ActiveRecord::Migration
  def change
    rename_table :documents_orders, :document_order
  end
end
