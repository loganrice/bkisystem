class Order < ActiveRecord::Base
  belongs_to :contract
  belongs_to :bank
  belongs_to :address
  belongs_to :mail_to, class_name: "Account", foreign_key: "mail_to_id"
  validates_presence_of :contract
  has_many :order_line_items, -> { order("created_at DESC")}
  has_many :commissions
  has_many :document_orders 
  has_many :documents, :through => :document_orders
  has_many :invoices
  has_one :certificate_of_origin
  has_one :fumigation
  accepts_nested_attributes_for :order_line_items, allow_destroy: true
  accepts_nested_attributes_for :commissions, allow_destroy: true
  accepts_nested_attributes_for :invoices, allow_destroy: true
  after_create :default_values

  def default_values
    copy_first_order_line_items_on_contract
    copy_first_order_commissions
    copy_first_order_values
  end

  def row_on_contract
    self.contract.orders.order(:created_at).each_with_index do |order, index|
      if order == self
        return index + 1
      end
    end
  end

  def discount
    total = BigDecimal("0")
    total += total_percent_discount if total_percent_discount
    total += total_discount_cents_per_pound if total_discount_cents_per_pound
    total += discount_cents if discount_cents 
    total.round(2).to_i
  end

  def discount_dollars_per_pound
    self.discount_cents_per_pound.to_f / 100
  end

  def discount_dollars_per_pound=(dollars)
    self.discount_cents_per_pound = (dollars.to_f * 100).to_i
  end

  def discount_dollars
    self.discount_cents.to_f / 100 
  end

  def discount_dollars=(dollars)
    self.discount_cents = (dollars.to_f * 100).to_i
  end

  def stakeholders
    stake_hldrs = []
    stake_hldrs << self.contract.seller
    stake_hldrs << self.contract.buyer
    self.commissions.each do |commission|
      stake_hldrs << commission.broker
    end 
    stake_hldrs.select { |x| !x.blank? }
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

  def total_price_less_discount
    if total_price
      total_price - discount
    else
      0
    end
  end

  def total_price_less_discount_plus_commission
    if total_price_less_discount
      total_price_less_discount + total_commission_cents
    else
      0
    end
  end

  def total_price_less_discount_less_commission
    if total_price_less_discount
      total_price_less_discount - total_commission_cents
    else
      0
    end
  end

  def total_commission_cents
    cents = 0
    self.commissions.each do |commission|
      cents += commission.total 
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
      copy_container_size(first_order_on_contract) if first_order_on_contract.container_size
      copy_documents(first_order_on_contract) if first_order_on_contract.documents
      copy_first_order_consignee(first_order_on_contract) if first_order_on_contract.consignee
    end
  end



  def copy_commissions(order)
    order.commissions.each do |commission|
      self.commissions << commission.dup
    end
  end

  def copy_line_items(order)
    if order.order_line_items
      order.order_line_items.each do |line_item|
        self.order_line_items << line_item.dup
      end
    end
  end

  def contract_has_at_least_1_order?
    self.contract.orders.count > 1
  end

  def first_order_on_contract
    self.contract.orders.first
  end

  private

  def copy_first_order_consignee(order)
    self.update_attributes(consignee: order.consignee) 
    self.update_attributes(line1: order.line1)
    self.update_attributes(line2: order.line2)
    self.update_attributes(line3: order.line3)
    self.update_attributes(city: order.city)
    self.update_attributes(state: order.state)
    self.update_attributes(zip: order.zip) 
    self.update_attributes(country: order.country) 
  end

  def round_money(cents)
    cents.round(2).to_i 
  end

  def total_percent_discount
    percentify(discount_percent) * BigDecimal(total_price.to_s)
  end

  def percentify(number)
    BigDecimal.new(number.to_s) / BigDecimal.new("100")
  end

  def total_discount_cents_per_pound
    discount_cents_per_pound * total_pounds if discount_cents_per_pound && total_pounds
  end

  def copy_container_size(order)
    update_attribute(:container_size, order.container_size)
  end

  def copy_documents(order)
    update_attribute(:documents, order.documents)
  end

end
