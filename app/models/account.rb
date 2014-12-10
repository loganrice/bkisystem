class Account < ActiveRecord::Base
  has_many :addresses, as: :addressable
  has_many :banks
  has_many :selling_contracts, :class_name => 'Contract', :foreign_key => 'seller_id'
  has_many :buying_contracts, :class_name => 'Contract', :foreign_key => 'buyer_id'
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :banks, allow_destroy: true
  validates_presence_of :name
end