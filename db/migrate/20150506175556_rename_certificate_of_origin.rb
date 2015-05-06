class RenameCertificateOfOrigin < ActiveRecord::Migration
  def change
    rename_table :certificiate_or_origins, :certificate_of_origins
  end
end
