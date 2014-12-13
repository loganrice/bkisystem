class Contract < ActiveRecord::Base
  belongs_to :seller, :class_name => "Account"
  belongs_to :buyer, :class_name => "Account"
  has_many :orders
  has_many :order_details, through: :orders
  accepts_nested_attributes_for :order_details, allow_destroy: true
  accepts_nested_attributes_for :orders, allow_destroy: true

  def commodity
    
  end
end