require 'spec_helper'

describe Commission do 
  it { should belong_to(:order) }
  it { should belong_to(:broker) }

  describe "#dollars_per_pound" do 
    it "displays 1293 cents per pound as 12.93 dollars per pound" do 
      amount = Commission.create(cents_per_pound: 1293)
      expect(amount.dollars_per_pound).to eq(12.93)
    end

    it "converts $12.93 dollars per pound to 1293 cents per pound" do 
      amount = Commission.create()
      amount.dollars_per_pound = 12.93
      expect(amount.cents_per_pound).to eq(1293)
    end
  end

  describe "#dollars" do 
    it "displays 1293 cents as 12.93 dollars" do 
      amount = Commission.create(cents: 1293)
      expect(amount.dollars).to eq(12.93)
    end
    it "converts $12.93 dollars to 1293 cents" do 
      amount = Commission.create()
      amount.dollars = 12.93999
      expect(amount.cents).to eq(1293)
    end
  end

  describe "#total_cents" do
    context "with accociated Order" do  
      it "multiplies commission percent by the order total cents" do 
        order = Fabricate(:order)
        item = OrderLineItem.create(order_id: order.id, price_cents: 100, pack_weight_pounds: 10, pack_count: 1)
        commission1 = Commission.create(percent: 2, broker_id: Fabricate(:account).id, order_id: order.id)
        order.commissions << commission1
        order.save
        expect(commission1.total).to eq(20)  
      end
      
      it "multiplies commission cents per pound by the total pounds" do 
        order = Fabricate(:order)
        item = OrderLineItem.create(order_id: order.id, price_cents: 100, pack_weight_pounds: 10, pack_count: 1)
        commission1 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id, order_id: order.id)
        order.commissions << commission1
        order.save
        expect(commission1.total).to eq(30)  
      end 

      it "returns the total of the 3 types of discount options into a single amount" do 
        order = Fabricate(:order)
        item = OrderLineItem.create(order_id: order.id, price_cents: 100, pack_weight_pounds: 10, pack_count: 1)
        commission1 = Commission.create(cents_per_pound: 3, cents: 100, percent: 10, broker_id: Fabricate(:account).id, order_id: order.id)
        order.commissions << commission1
        order.save
        expect(commission1.total).to eq(230)
      end 

    end
  end
end