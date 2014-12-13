require 'spec_helper'

describe OrderDetail do 
  it { should belong_to(:order) }

  describe "#price_dollars=" do
    it "converts $12.93 dollars to 1293 cents" do 
      amount = OrderDetail.create()
      amount.price_dollars = 12.93
      expect(amount.price_cents).to eq(1293)
    end
  end

  describe "#price_dollars" do 
    it "displays 1293 cents as 12.93" do 
      amount = OrderDetail.create(price_cents: 1293)
      expect(amount.price_dollars).to eq(12.93)
    end
  end

  describe "#shipment_date" do 
    it "displays order date 2/3/2020" do 
      new_shipment = Fabricate(:order, ship_date: Date.new(2020,2,3) )
      container = OrderDetail.create()
      container.order = new_shipment
      expect(container.shipment_date).to eq(Date.new(2020,2,3))
    end
  end

  describe "#load" do 
    it "displays the order detail count in the order that it was created" do
      new_shipment = Fabricate(:order)
      order_day_ago = OrderDetail.create(order_id: new_shipment.id, created_at: 1.day.ago)
      order_month_ago = OrderDetail.create(order_id: new_shipment.id, created_at: 1.month.ago)
      order_hour_ago = OrderDetail.create(order_id: new_shipment.id, created_at: 1.hour.ago)
 
      expect([order_hour_ago.load, order_day_ago.load, order_month_ago.load]).to eq([1,2,3])

    end
  end

end