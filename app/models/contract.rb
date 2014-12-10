class Contract < ActiveRecord::Base
  belongs_to :seller, :class_name => "Account"
  belongs_to :buyer, :class_name => "Account"
end