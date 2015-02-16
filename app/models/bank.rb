class Bank < ActiveRecord::Base
  belongs_to :account
  has_many :orders
  has_many :invoices
end