class ChangePortOfLoadingFormatInCertificateOfOrigins < ActiveRecord::Migration
  def change
    change_column :certificate_of_origins, :port_of_loading, :string
  end
end
