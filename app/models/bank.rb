class Bank < ActiveRecord::Base
  belongs_to :account
  has_many :orders
end