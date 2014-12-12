require 'spec_helper'

describe Container do 
  it { should belong_to(:shipment) }

  describe "#price_dollars=" do
    it "converts $12.93 dollars to 1293 cents" do 
      amount = Container.create()
      amount.price_dollars = 12.93
      expect(amount.price_cents).to eq(1293)
    end
  end

  describe "#price_dollars" do 
    it "displays 1293 cents as 12.93" do 
      amount = Container.create(price_cents: 1293)
      expect(amount.price_dollars).to eq(12.93)
    end
  end

  describe "#shipment_date" do 
    it "displays shipment date 2/3/2020" do 
      new_shipment = Fabricate(:shipment, ship_date: Date.new(2020,2,3) )
      container = Container.create()
      container.shipment = new_shipment
      expect(container.shipment_date).to eq(Date.new(2020,2,3))
    end
  end

  describe "#load" do 
    it "displays the container count in the order that it was created" do
      new_shipment = Fabricate(:shipment)
      container_day_ago = Container.create(shipment_id: new_shipment.id, created_at: 1.day.ago)
      container_month_ago = Container.create(shipment_id: new_shipment.id, created_at: 1.month.ago)
      container_hour_ago = Container.create(shipment_id: new_shipment.id, created_at: 1.hour.ago)
 
      expect([container_hour_ago.load, container_day_ago.load, container_month_ago.load]).to eq([1,2,3])

    end
  end

end