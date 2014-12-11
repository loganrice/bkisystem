class Shipment < ActiveRecord::Base
  belongs_to :contract
end