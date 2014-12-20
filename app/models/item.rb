class Item < ActiveRecord::Base
  belongs_to :commodity
  belongs_to :size
  belongs_to :variety
  belongs_to :grade
  has_many :quote_line_items
  has_many :order_line_items
  validates_presence_of :name
  validates_presence_of :commodity_id
end