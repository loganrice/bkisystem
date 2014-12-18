class Weight < ActiveRecord::Base
  has_many :order_line_items
end