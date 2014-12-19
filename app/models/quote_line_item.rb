class QuoteLineItem < ActiveRecord::Base
  belongs_to :quote
  belongs_to :item
  has_many :order_line_items, dependent: :destroy

  before_destroy :destroy_order_line_items

  def price_dollars=(dollars)
    self.price_cents = (dollars.to_f * 100).to_i
  end

  def price_dollars
    self.price_cents.to_f / 100
  end

  def destroy_order_line_items
    self.order_line_items.delete_all   
  end

end