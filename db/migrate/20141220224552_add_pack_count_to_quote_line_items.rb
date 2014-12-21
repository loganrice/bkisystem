class AddPackCountToQuoteLineItems < ActiveRecord::Migration
  def change
    add_column :quote_line_items, :pack_count, :integer 
  end
end
