class Invoice < ActiveRecord::Base
  belongs_to :order
  belongs_to :bank
  belongs_to :payee, class_name: "Account"
  belongs_to :payer, class_name: "Account"
  belongs_to :address
  validates_presence_of :payee_id, :payer_id, :bank_id, :address_id, :order_id
end