class Order < ActiveRecord::Base
  belongs_to :contract
  has_many :order_details, -> { order("created_at DESC")}
  accepts_nested_attributes_for :order_details, allow_destroy: true
  
end