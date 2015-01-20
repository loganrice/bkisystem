class DocumentOrder < ActiveRecord::Base
  belongs_to :document
  belongs_to :order
end