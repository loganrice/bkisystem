class Order < ActiveRecord::Base
  belongs_to :contract
  validates_presence_of :contract
  has_many :order_line_items, -> { order("created_at DESC")}
  has_many :commissions
  accepts_nested_attributes_for :order_line_items, allow_destroy: true
  accepts_nested_attributes_for :commissions, allow_destroy: true
  before_save :default_values

  def default_values

  end

  def row_on_contract
    self.contract.orders.each_with_index do |order, index|
      if order == self
        return index + 1
      end
    end
  end

  def total_pounds
    pounds = BigDecimal("0")
    self.order_line_items.each do |line_item|
      pounds += line_item.weight_total
    end
    pounds
  end

  def total_price
    cents = 0
    self.order_line_items.each do |line_item|
      cents += line_item.invoice_total
    end
    cents
  end

  def price_dollars(cents)
    cents.to_f / 100
  end
end