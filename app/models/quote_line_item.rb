class QuoteLineItem < ActiveRecord::Base
  belongs_to :quote
  belongs_to :item
  has_many :order_line_items
end