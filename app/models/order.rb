class Order < ActiveRecord::Base
  belongs_to :contract
  belongs_to :bank
  belongs_to :address
  belongs_to :mail_to, class_name: "Account"
  belongs_to :acting_seller, class_name: "Account"
  validates_presence_of :contract
  has_many :order_line_items, -> { order("created_at DESC")}
  has_many :commissions
  has_many :document_orders 
  has_many :documents, :through => :document_orders
  accepts_nested_attributes_for :order_line_items, allow_destroy: true
  accepts_nested_attributes_for :commissions, allow_destroy: true
  before_create :default_values
  after_create :copy_first_order_line_items_on_contract, :copy_first_order_commissions, :copy_first_order_values

  def default_values
    acting_seller = self.contract.seller if row_on_contract == 1
    mail_to = self.contract.seller if row_on_contract == 1 
  end

  def row_on_contract
    self.contract.orders.each_with_index do |order, index|
      if order == self
        return index + 1
      end
    end
  end

  def stakeholders
    stake_hldrs = []
    stake_hldrs << self.contract.seller
    stake_hldrs << self.contract.buyer
    self.commissions.each do |commission|
      stake_hldrs << commission.broker
    end 
    stake_hldrs
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

      if first_order_on_contract.documents
        copy_documents(first_order_on_contract)
      end

      copy_mail_to(first_order_on_contract)
      copy_acting_seller(first_order_on_contract)

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

  def copy_documents(order)
    update_attribute(:documents, order.documents)
  end

  def copy_acting_seller(order)
    update_attribute(:acting_seller_id, order.acting_seller_id)
  end

  def copy_mail_to(order)
    update_attribute(:mail_to_id, order.mail_to_id)
  end
end