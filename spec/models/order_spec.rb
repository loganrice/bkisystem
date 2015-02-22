require 'spec_helper'

describe Order do 
  it { should belong_to(:contract) }
  it { should have_many(:order_line_items) }
  it { should accept_nested_attributes_for(:order_line_items) }
  it { should validate_presence_of(:contract)}
  it { should have_many(:commissions) }
  it { should accept_nested_attributes_for(:commissions) }
  it { should have_many(:documents).through(:document_orders)}
  it { should belong_to(:bank) }
  it { should belong_to(:address) }
  it { should belong_to(:mail_to) }
  it { should have_many(:invoices) }
  it { should accept_nested_attributes_for(:invoices)}

  
  it "sort OrderDetails sort descending order by creation date" do 
    order = Fabricate(:order)
    month_ago = Fabricate(:order_line_item, created_at: 1.month.ago, order_id: order.id)
    hour_ago = Fabricate(:order_line_item, created_at: 1.hour.ago, order_id: order.id)
    day_ago = Fabricate(:order_line_item, created_at: 1.day.ago, order_id: order.id)
    order.reload
    expect(order.order_line_items).to eq([hour_ago, day_ago, month_ago])

  end

  describe "#discount" do 
    it "multiplies discount_percent by total_price" do 
      order = Fabricate(:order, discount_percent: 10)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 1, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 1, pack_count: 1)
      expect(order.discount).to eq(20)
    end

    it "multiplies discount_cents_per_pound by total_pounds" do
      order = Fabricate(:order, discount_cents_per_pound: 2)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      expect(order.discount).to eq(400)      
    end
    it "subtracts discount_cents by total_price" do 
      order = Fabricate(:order, discount_cents: 500)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      expect(order.discount).to eq(500)  
    end
    it "returns the total of the 3 types of discount options into a single amount" do 
      order = Fabricate(:order, discount_percent: 10, discount_cents: 500, discount_cents_per_pound: 2)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      expect(order.discount).to eq(2900) 
    end

  end

  describe "#total_price_less_discount" do 
    it "should subtract 2900 cents from a 20000 cent order" do 
      order = Fabricate(:order, discount_percent: 10, discount_cents: 500, discount_cents_per_pound: 2)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      expect(order.total_price_less_discount).to eq(17100) 
    end
  end

  describe "#discount_dollars_per_pound" do 
    it "should convert 200 to 2 dollars" do 
      order = Fabricate(:order, discount_cents_per_pound: 200)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      expect(order.discount_dollars_per_pound).to eq(2) 
    end
  end

  describe "#discount_dollars_per_pound=" do
    it "should store 150 cents given 1.497777 dollars" do  
      order = Fabricate(:order)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      order.discount_dollars_per_pound = 1.50  
      expect(order.discount_dollars_per_pound).to eq(1.50)
    end 
  end

  describe "#discount_dollars" do 
    it "converts 200 to 2 dollars" do 
      order = Fabricate(:order, discount_cents: 200)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      expect(order.discount_dollars).to eq(2) 
    end
  end

  describe "#discount_dollars=" do 
    it "should store 200 cents given 2 dollars" do 
      order = Fabricate(:order)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, price_cents: 100, pack_weight_pounds: 100, pack_count: 1)
      order.discount_dollars = 2   
      expect(order.discount_cents).to eq(200)
    end
  end

  describe "#stakeholders" do 
    it "returns an array of all the accounts on the contract" do 
      buyer = Fabricate(:account)
      seller = Fabricate(:account)
      contract = Fabricate(:contract, buyer_id: buyer.id, seller_id: seller.id)
      order = Fabricate(:order, contract_id: contract.id)

      expect(order.stakeholders).to match_array [buyer, seller]
    end

    it "returns an array of all the brokers on the contract" do 
      buyer = Fabricate(:account)
      seller = Fabricate(:account)
      broker1 = Fabricate(:account)
      broker2 = Fabricate(:account)
      commission1 = Commission.create(broker_id: broker1.id, cents_per_pound: 3)
      commission2 = Commission.create(broker_id: broker2.id, cents_per_pound: 3)

      contract = Fabricate(:contract, buyer_id: buyer.id, seller_id: seller.id)
      order = Fabricate(:order, contract_id: contract.id)
      order.commissions << commission1
      order.commissions << commission2
      
      expect(order.stakeholders).to match_array [broker1, broker2, buyer, seller]
    end
  end

  describe "#row_on_contract" do 
    it "asks it's parent contract to return it's position in the array of orders" do
      require 'pry';
      contract = Fabricate(:contract)
      order1 = Fabricate(:order, contract_id: contract.id)
      order2 = Fabricate(:order, contract_id: contract.id)
      order3 = Fabricate(:order, contract_id: contract.id)

      expect(order2.row_on_contract).to eq (2)
    end
  end

  describe "#total_pounds" do 
    it "sums up all the pounds in the order line items" do 
      order = Fabricate(:order)
      line_item1 = Fabricate(:order_line_item, order_id: order.id, pack_count: 1, pack_weight_pounds: 1000)
      line_item2 = Fabricate(:order_line_item, order_id: order.id, pack_count: 1, pack_weight_pounds: 1000) 
      expect(order.total_pounds).to eq(2000)     
    end
  end

  describe "#total_price" do 
    it "sums up all the price in dollars of the order line items" do 
      order = Fabricate(:order)
      item = OrderLineItem.create(order_id: order.id, price_cents: 452, pack_weight_pounds: 50, pack_count: 447)
      commission1 = Commission.create(percent: 2, broker_id: Fabricate(:account).id)
      commission2 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id)
      order.commissions << commission1
      order.commissions << commission2
      order.save
      expect(order.total_price).to eq(10102200)     
    end
  end

  describe "#total_commission_cents" do 
    context "with associated Commission" do 
      it "adds all of the commissions" do 
        order = Fabricate(:order)
        item = OrderLineItem.create(order_id: order.id, price_cents: 100, pack_weight_pounds: 10, pack_count: 1)
        commission1 = Commission.create(percent: 2, broker_id: Fabricate(:account).id, order_id: order.id)
        commission2 = Commission.create(cents_per_pound: 3, broker_id: Fabricate(:account).id, order_id: order.id)
        commission2 = Commission.create(cents: 100, broker_id: Fabricate(:account).id, order_id: order.id)
        expect(order.total_commission_cents).to eq(150)      
      end
    end
  end


  describe "#copy_first_order_line_items" do 
    it "copies the fields from the first order on the contract" do
      order = Fabricate(:order)
      item = Fabricate(:item)
      lb = Weight.create(weight_unit_of_measure: "lbs")
      order.order_line_items << OrderLineItem.create(item_id: item.id, price_cents: 100,
                                                      order_id: order.id, weight_id: lb.id,
                                                      pack_weight_pounds: 50, pack_count: 10 ) 
      contract = Fabricate(:contract)
      contract.orders << order
      new_order = contract.orders.create()
      # all attributes except for id and created dates should copy
      # only testing the item item_id for brevity
      old_order_last_item = order.order_line_items.last.attributes
      new_order_last_item = new_order.order_line_items.last.attributes
   
      expect(new_order_last_item["item_id"]).to eq(old_order_last_item["item_id"])
    end
  end

  describe "#copy_first_order_commissions" do 
    it "copies the commissions from the first order on the contract" do
      contract = Fabricate(:contract)
      order = Fabricate(:order, contract_id: contract.id)
      item = Fabricate(:item)
      lb = Weight.create(weight_unit_of_measure: "lbs")
      order.order_line_items << OrderLineItem.create(item_id: item.id, price_cents: 100,
                                                      order_id: order.id, weight_id: lb.id,
                                                      pack_weight_pounds: 50, pack_count: 10 ) 
      commission = Fabricate(:commission, order_id: order.id)
      new_order = contract.orders.create()

      first_order_last_commission = order.commissions.last.attributes
      new_order_last_commission = new_order.commissions.last.attributes
      # all attributes except for id and created dates should copy
      # only testing the cents_per_pound for brevity
      expect(new_order_last_commission["cents_per_pound"]).to eq(first_order_last_commission["cents_per_pound"])
    end
  end

  describe "#copy_first_order" do 
    it "Copies all of the documents from the first order on contract" do 
      contract = Fabricate(:contract)
      order = Fabricate(:order, contract_id: contract.id)
      doc1 = Document.create(name: "doc1")
      doc2 = Document.create(name: "doc2")
      order.documents << doc1
      order.documents << doc2
      order.save

      new_order = contract.orders.create()

      expect(new_order.documents).to eq(order.documents)
    end
  end

end