class Account < ActiveRecord::Base
  has_many :addresses, as: :addressable
  accepts_nested_attributes_for :addresses, allow_destroy: true
  validates_presence_of :name
end