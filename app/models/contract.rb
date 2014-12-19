class Contract < ActiveRecord::Base
  belongs_to :seller, :class_name => "Account"
  belongs_to :buyer, :class_name => "Account"
  has_many :orders
  has_one :quote
  has_many :quote_line_items, through: :quote
  accepts_nested_attributes_for :orders, allow_destroy: true
  accepts_nested_attributes_for :quote, allow_destroy: true
  after_save :update_order_line_items_from_quote_line_items

  private 

  def update_order_line_items_from_quote_line_items
    self.orders.each do |order|
      order.order_line_items.each do |line_item|
        update_order_item(line_item)
      end
    end
  end

  def update_order_item(line_item)
    quote = get_quote(line_item)
    item = get_item_from_quote(quote)
    line_item.item = item 
  end

  def get_quote(order_line)
    id = order_line.quote_line_item_id 
    QuoteLineItem.find(id)
  end

  def get_item_from_quote(quote_line)
    id = quote_line.item_id
    Item.find(id) 
  end
end