class Contract < ActiveRecord::Base
  belongs_to :seller, :class_name => "Account"
  belongs_to :buyer, :class_name => "Account"
  has_many :orders
  has_many :quotes
  has_many :quote_line_items, through: :quotes
  accepts_nested_attributes_for :orders, allow_destroy: true
  accepts_nested_attributes_for :quotes, allow_destroy: true
end