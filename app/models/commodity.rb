class Commodity < ActiveRecord::Base
  has_many :items
end