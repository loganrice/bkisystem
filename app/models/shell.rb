class Shell < ActiveRecord::Base
  has_many :items
  validates_presence_of :name
end