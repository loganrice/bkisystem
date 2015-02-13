class Address < ActiveRecord::Base
  belongs_to :addressable, polymorphic: true
  has_many :orders
end