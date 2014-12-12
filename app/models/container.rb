class Container < ActiveRecord::Base
  belongs_to :shipment
  
  def price_dollars=(dollars)
    self.price_cents = dollars * 100
  end

  def price_dollars
    self.price_cents.to_f / 100
  end
end