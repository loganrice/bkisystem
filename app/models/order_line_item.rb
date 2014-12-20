class OrderLineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item 
  belongs_to :quote_line_item
  belongs_to :weight
  before_save :set_price_if_blank

  def price_dollars=(dollars)
    self.price_cents = (dollars.to_f * 100).to_i
  end

  def price_dollars
    self.price_cents.to_f / 100
  end

  def shipment_date
    self.order.ship_date
  end

  def weight_kilograms
    self.weight_grams.to_f / 1000
  end

  def weight_kilograms=(kilograms)
    self.weight_grams = kilograms.to_f * 1000
  end

  def weight_pounds
    self.weight_grams.to_f * 0.00220462262185
  end

  def weight_pounds=(pounds)
    self.weight_grams = pounds.to_f / 0.00220462262185
  end

  private

  def set_price_if_blank
    self.price_cents ||= 0
  end

end