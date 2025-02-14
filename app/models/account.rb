class Account < ActiveRecord::Base
  has_many :addresses, as: :addressable
  has_many :banks
  has_many :selling_contracts, class_name: 'Contract', foreign_key: 'seller_id'
  has_many :buying_contracts, class_name: 'Contract', foreign_key: 'buyer_id'
  has_many :commissions, class_name: 'Commission', foreign_key: 'broker_id'
  has_many :acting_sellers, class_name: 'Contract', foreign_key: 'acting_seller_id'
  has_many :payees, class_name: 'Invoice', foreign_key: 'payee_id'
  has_many :payers, class_name: 'Invoice', foreign_key: 'payer_id'
  has_many :mail_tos, class_name: 'Invoice', foreign_key: 'mail_to_id'
  accepts_nested_attributes_for :addresses, allow_destroy: true
  accepts_nested_attributes_for :banks, allow_destroy: true
  validates_presence_of :name
end