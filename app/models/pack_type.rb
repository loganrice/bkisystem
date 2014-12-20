class PackType < ActiveRecord::Base
  has_many :quote_line_items
end