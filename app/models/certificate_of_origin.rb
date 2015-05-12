class CertificateOfOrigin < ActiveRecord::Base
  belongs_to :order
  validates_presence_of :order
  validates_presence_of :forwarding_agent
end