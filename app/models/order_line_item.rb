class OrderLineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item 
  belongs_to :quote_line_item
  
  def price_dollars=(dollars)
    self.price_cents = dollars * 100
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
    self.weight_grams = kilograms * 1000
  end

  def weight_pounds
    self.weight_grams.to_f * 0.00220462262185
  end

  def weight_pounds=(pounds)
    self.weight_grams = pounds / 0.00220462262185
  end
end