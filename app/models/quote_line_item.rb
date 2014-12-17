class QuoteLineItem < ActiveRecord::Base
  belongs_to :quote
  belongs_to :item
  has_many :order_line_items

  def price_dollars=(dollars)
    self.price_cents = dollars * 100
  end

  def price_dollars
    self.price_cents.to_f / 100
  end

end