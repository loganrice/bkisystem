class Item < ActiveRecord::Base
  belongs_to :commodity
  belongs_to :size
  belongs_to :variety
  validates_presence_of :name
  validates_presence_of :commodity_id
end