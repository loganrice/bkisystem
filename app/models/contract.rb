class Contract < ActiveRecord::Base
  belongs_to :seller, :class_name => "Account"
  belongs_to :buyer, :class_name => "Account"
  has_many :shipments
  accepts_nested_attributes_for :shipments, allow_destroy: true
end