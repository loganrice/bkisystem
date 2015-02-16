class Invoice < ActiveRecord::Base
  belongs_to :order
  belongs_to :bank
  belongs_to :payee, class_name: "Account"
  belongs_to :payer, class_name: "Account"
  belongs_to :address
  has_many :invoice_line_items
  accepts_nested_attributes_for :invoice_line_items, allow_destroy: true
  validates_presence_of :payee_id, :payer_id, :bank_id, :address_id, :order_id
  after_create :add_invoice_line_item

  def add_invoice_line_item
    self.invoice_line_items.build()
  end
end