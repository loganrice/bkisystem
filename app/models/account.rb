class Account < ActiveRecord::Base
  has_many :addresses, as: :addressable
  has_many :banks
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :banks, allow_destroy: true
  validates_presence_of :name
end