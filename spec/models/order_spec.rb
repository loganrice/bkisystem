require 'spec_helper'

describe Order do 
  it { should belong_to(:contract) }
  it { should have_many(:order_line_items) }
  it { should accept_nested_attributes_for(:order_line_items) }
  it { should validate_presence_of(:contract)}

  it "sort OrderDetails sort descending order by creation date" do 
    order = Fabricate(:order)
    month_ago = Fabricate(:order_line_item, created_at: 1.month.ago, order_id: order.id)
    hour_ago = Fabricate(:order_line_item, created_at: 1.hour.ago, order_id: order.id)
    day_ago = Fabricate(:order_line_item, created_at: 1.day.ago, order_id: order.id)
    order.reload
    expect(order.order_line_items).to eq([hour_ago, day_ago, month_ago])

  end
  
  describe "#row_on_contract" do 
    it "asks it's parent contract to return it's position in the array of orders" do
      contract = Fabricate(:contract)
      order1 = Fabricate(:order, contract_id: contract.id)
      order2 = Fabricate(:order, contract_id: contract.id)
      order3 = Fabricate(:order, contract_id: contract.id)

      expect(order2.row_on_contract).to eq (2)
    end
  end

  describe "#total_pounds" do 
    it "sums up all of the weights in pounds of the order line items" do 
      order = Fabricate(:order)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, weight_grams: 1000)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, weight_grams: 1000)

      expect(order.total_pounds).to eq(4.4092452437)
    end
  end

  describe "#total_price" do 
    it "sums up all the price in dollars of the order line items" do 
      order = Fabricate(:order)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 1000)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 293)

      expect(order.total_price).to eq(12.93)
    end
  end
end