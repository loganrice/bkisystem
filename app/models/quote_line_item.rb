class QuoteLineItem < ActiveRecord::Base
  belongs_to :quote
  belongs_to :item
  belongs_to :item_size_indicator
  has_many :order_line_items, dependent: :destroy
  belongs_to :pack_type
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

end