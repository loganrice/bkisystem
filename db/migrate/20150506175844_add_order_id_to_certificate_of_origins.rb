class AddOrderIdToCertificateOfOrigins < ActiveRecord::Migration
  def change
    add_column :certificate_of_origins, :order_id, :integer
  end
end
