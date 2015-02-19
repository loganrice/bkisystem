class Commission < ActiveRecord::Base
  belongs_to :order
  belongs_to :broker, :class_name => "Account"

  def dollars_per_pound
    self.cents_per_pound.to_f / 100
  end

  def dollars_per_pound=(dollars)
    self.cents_per_pound = (dollars.to_f * 100).to_i
  end

  def dollars
    self.cents.to_f / 100
  end

  def dollars=(dollars)
    self.cents = (dollars.to_f * 100).to_i
  end

  def total
    total_amount = BigDecimal.new("0")
    if self.order.total_price_less_discount
      total_amount += percentify(percent) * self.order.total_price_less_discount if percent 
      total_amount += (cents_per_pound * self.order.total_pounds) if cents_per_pound && self.order.total_pounds
      total_amount += cents if cents  
    end
    total_amount.round(2).to_i
  end

  private
  def percentify(number)
    BigDecimal.new(number.to_s) / BigDecimal.new("100")
  end
end