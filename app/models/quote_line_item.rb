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
    self.pack_weight_grams.to_f / 1000
  end

  def pack_weight_kilograms=(kilograms)
    self.pack_weight_grams = kilograms.to_f * 1000
  end

  def pack_weight_pounds
    self.pack_weight_grams.to_f * 0.00220462262185
  end

  def pack_weight_pounds=(pounds)
    self.pack_weight_grams = pounds.to_f / 0.00220462262185
  end

end