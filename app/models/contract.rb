class Contract < ActiveRecord::Base
  belongs_to :seller, :class_name => "Account"
  belongs_to :buyer, :class_name => "Account"
  has_many :orders
  has_one :quote
  has_many :quote_line_items, through: :quote
  accepts_nested_attributes_for :orders, allow_destroy: true
  accepts_nested_attributes_for :quote, allow_destroy: true
  before_create :create_quote
  validates_presence_of :buyer, :seller

  def order_container_sizes
    container_sizes = {}
    self.orders.each do |order|
      if container_sizes.has_key? order.container_size
        container_sizes[order.container_size] = (container_sizes[order.container_size] + 1)
      else
        container_sizes[order.container_size] = 1
      end
    end
    container_sizes 
  end

  def total_pounds
    pounds = BigDecimal("0")
    self.orders.each do |order|
      if order.total_pounds
        pounds += order.total_pounds
      end
    end
    pounds.round(0)
  end

  private 

  def create_quote
    self.quote ||= Quote.create()
  end

end