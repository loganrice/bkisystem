class Order < ActiveRecord::Base
  belongs_to :contract
  has_many :order_line_items, -> { order("created_at DESC")}
  accepts_nested_attributes_for :order_line_items, allow_destroy: true
  
end