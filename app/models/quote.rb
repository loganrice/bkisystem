class Quote < ActiveRecord::Base
  belongs_to :contract
  has_many :quote_line_items
  accepts_nested_attributes_for :quote_line_items, allow_destroy: true
end