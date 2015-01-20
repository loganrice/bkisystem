class RenameOrderDocumentsToDocuments < ActiveRecord::Migration
  def change
    rename_table :order_documents, :documents
  end
end
