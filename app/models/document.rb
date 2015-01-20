class Document < ActiveRecord::Base
  has_many :document_orders
  has_many :orders, :through => :document_orders
  validates_presence_of :name
end