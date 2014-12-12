class Shipment < ActiveRecord::Base
  belongs_to :contract
  has_many :containers, -> { order("created_at DESC")}

end