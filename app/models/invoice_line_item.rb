class InvoiceLineItem < ActiveRecord::Base
  belongs_to :invoice
  validates_presence_of :amount_cents

  def amount_dollars=(dollars)
    dollars = dollars.to_s
    dollars = BigDecimal.new(dollars)
    self.amount_cents = (dollars * 100).to_i
  end

  def amount_dollars
    self.amount_cents.to_f / 100
  end
end