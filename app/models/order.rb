class Order < ActiveRecord::Base
  belongs_to :contract
  validates_presence_of :contract
  has_many :order_line_items, -> { order("created_at DESC")}
  has_many :commissions
  has_many :document_orders 
  has_many :documents, :through => :document_orders
  accepts_nested_attributes_for :order_line_items, allow_destroy: true
  accepts_nested_attributes_for :commissions, allow_destroy: true
  before_save :default_values
  after_create :copy_first_order_line_items_on_contract, :copy_first_order_commissions, :copy_first_order_values

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

  def copy_first_order_line_items_on_contract
    if contract_has_at_least_1_order?
      self.copy_line_items(first_order_on_contract)
    end
  end

  def copy_first_order_commissions
    if contract_has_at_least_1_order?
      self.copy_commissions(first_order_on_contract)
    end
  end

  def copy_first_order_values
    if contract_has_at_least_1_order?
      if first_order_on_contract.container_size
        copy_container_size(first_order_on_contract)
      end
    end
  end

  def copy_commissions(order)
    order.commissions.each do |commission|
      self.commissions << commission.dup
    end
  end

  def copy_line_items(order)
    order.order_line_items.each do |line_item|
      self.order_line_items << line_item.dup
    end
  end

  def contract_has_at_least_1_order?
    self.contract.orders.count > 0
  end

  def first_order_on_contract
    self.contract.orders.first
  end

  private

  def copy_container_size(order)
    update_attribute(:container_size, order.container_size)
  end
end