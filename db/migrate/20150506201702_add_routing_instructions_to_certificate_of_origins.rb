class AddRoutingInstructionsToCertificateOfOrigins < ActiveRecord::Migration
  def change
    add_column :certificate_of_origins, :routing_instructions, :text
  end
end
