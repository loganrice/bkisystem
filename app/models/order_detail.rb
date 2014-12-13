class OrderDetail < ActiveRecord::Base
  belongs_to :order
  
  def price_dollars=(dollars)
    self.price_cents = dollars * 100
  end

  def price_dollars
    self.price_cents.to_f / 100
  end

  def shipment_date
    self.order.ship_date
  end

  def load
    self.order.order_details.index(self) + 1
  end

  def load=(order)
    self.order = order 
  end
end