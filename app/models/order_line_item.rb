class OrderLineItem < ActiveRecord::Base
  belongs_to :order
  belongs_to :item 
  belongs_to :quote_line_item
  belongs_to :weight
  before_save :default_values
  has_many :commissions, through: :order
  before_save :default_values
  
  def price_dollars=(dollars)
    dollars = dollars.to_s
    dollars = BigDecimal.new(dollars)
    self.price_cents = (dollars * 100).to_i
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
  
  def total_commission_cents_per_pound
    cents = 0
    self.commissions.each do |commission|
      commission_cents = commission.cents_per_pound
      cents += commission_cents if commission_cents
    end
    cents
  end

  def total_commission_percent
    percent = 0
    self.commissions.each do |commission|
      percent += commission.percent if commission.percent 
    end
    percent = percent
  end

  def total_commission_percent_as_decimal
    BigDecimal.new(total_commission_percent / BigDecimal.new("100") ) if total_commission_percent > 0
  end

  def total_commission_cents
    cents = 0
    self.commissions.each do |commission|
      if commission.cents
        cents += commission.cents
      end
    end
    cents ||= 0
  end

  def adjusted_price
    commission = BigDecimal("0")
    if total_commission_percent_as_decimal && self.price_cents
      commission += (self.price_cents * total_commission_percent_as_decimal)
    end
    commission += total_commission_cents_per_pound
    (self.price_cents - commission)
  end

  def adjusted_total
    adjusted_price * weight_total
  end

  def invoice_total
    self.price_cents * weight_total
  end

  def commission_total
    commission = 0
    if total_commission_percent_as_decimal && self.price_cents
      commission_percent = (invoice_total * total_commission_percent_as_decimal)
    end

    commission_cents_per_pound = total_commission_cents_per_pound * weight_total
    
    commission += commission_percent if commission_percent
    commission += commission_cents_per_pound if commission_cents_per_pound
    commission += total_commission_cents if total_commission_cents
    commission
  end

  def weight_total
    self.pack_weight_pounds * self.pack_count
  end

  private

  def default_values
    self.price_cents ||= 0
    self.pack_count ||= 0
    self.pack_weight_pounds ||= 0
  end

end