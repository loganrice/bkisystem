require 'spec_helper'

describe Contract do 
  it { should belong_to(:buyer) }
  it { should belong_to(:seller) }
  it { should have_one(:quote) }
  it { should have_many(:quote_line_items).through(:quote)}
  it { should have_many(:orders) }
  it { should accept_nested_attributes_for(:orders) }

  describe "#update_order_line_item_with_quote_line_item" do 
    it "updates the order_line_item_price with the quote price"
    it "updates the order_line_item.item_id with the quote item" do 
      contract = Contract.create()
      quote = Fabricate(:quote)
      contract.quote = quote
      item = Fabricate(:item)

      quote_line_item = Fabricate(:quote_line_item, price_cents: 100, item_id: item.id)
      order_line_item = Fabricate(:order_line_item, quote_line_item_id: quote_line_item.id, item_id: nil)
      
      quote.quote_line_items << quote_line_item

      order = Fabricate(:order)
      order.order_line_items << order_line_item
      contract.orders << order
      
      contract.save
      contract.reload
      first_line_on_first_order = Contract.first.orders.first.order_line_items.first
      expect(first_line_on_first_order.item_id).to eq(quote_line_item.item_id)

    end
  end
end

