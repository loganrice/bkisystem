class OrderLineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item 
  belongs_to :quote_line_item
  belongs_to :weight
  before_save :default_values

  def price_dollars=(dollars)
    self.price_cents = (dollars.to_f * 100).to_i
  end

  def price_dollars
    self.price_cents.to_f / 100
  end

  def shipment_date
    self.order.ship_date
  end

  def pack_weight_kilograms
    to_kg(self.pack_weight_pounds)
  end

  def pack_weight_kilograms=(kilograms)
    kilograms = BigDecimal(kilograms)
    self.pack_weight_pounds = to_lbs(kilograms)
  end

  def to_kg(pounds)
    convert_rate = BigDecimal("0.45359237")
    near_exact = BigDecimal(pounds * convert_rate)
    near_exact.round(3)
  end

  def to_lbs(kilograms)
    convert_rate = BigDecimal("0.45359237")
    near_exact = BigDecimal(kilograms / convert_rate)
    near_exact.round(3)
  end
  
  private

  def default_values
    self.price_cents ||= 0
  end

end