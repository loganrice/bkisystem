class Item < ActiveRecord::Base
  belongs_to :commodity
  validates_presence_of :description
  validates_presence_of :commodity_id
end