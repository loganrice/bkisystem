class Item < ActiveRecord::Base
  belongs_to :commodity
  belongs_to :size
  validates_presence_of :description
  validates_presence_of :commodity_id
end