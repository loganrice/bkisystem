class Order < ActiveRecord::Base
  belongs_to :contract
  validates_presence_of :contract
  has_many :order_line_items, -> { order("created_at DESC")}
  accepts_nested_attributes_for :order_line_items, allow_destroy: true
  
  def row_on_contract
    self.contract.orders.each_with_index do |order, index|
      if order == self
        return index + 1
      end
    end
  end

  def total_price
    cents = 0
    self.order_line_items.each do |line_item|
      cents += line_item.price_cents
    end
    price_dollars(cents)
  end

  def total_pounds
    grams = 0
    self.order_line_items.each do |line_item|
      grams += line_item.weight_grams
    end
    weight_pounds(grams)
  end

  def weight_pounds(grams)
    grams.to_f * 0.00220462262185
  end

  def price_dollars(cents)
    cents.to_f / 100
  end
end