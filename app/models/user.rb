class User < ActiveRecord::Base
  has_secure_password validations: false
  validates_presence_of :name 
  validates_presence_of :password
end