class Order < ActiveRecord::Base
  belongs_to :contract
  has_many :order_details, -> { order("created_at DESC")}

end