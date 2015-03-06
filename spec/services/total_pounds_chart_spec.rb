require 'spec_helper'

describe TotalPoundsChart do
  let(:set_up_order) do
    order = Fabricate(:order)
    butte = Variety.create(name: "butte")
    nonpariel = Variety.create(name: "nonpariel")
    carmel = Variety.create(name: "carmel")
    mission = Variety.create(name: "mission")
    butte_item = Fabricate(:item)
    nonpariel_item = Fabricate(:item)
    carmel_item = Fabricate(:item)
    mission_item = Fabricate(:item)
    butte_item.variety.update_attributes(name: "butte")
    nonpariel_item.variety.update_attributes(name: "nonpariel")
    carmel_item.variety.update_attributes(name: "carmel")
    mission_item.variety.update_attributes(name: "mission")
    OrderLineItem.create(order_id: order.id, item_id: butte_item.id, price_cents: 452, pack_weight_pounds: 100, pack_count: 10)
    OrderLineItem.create(order_id: order.id, item_id: nonpariel_item.id, price_cents: 452, pack_weight_pounds: 550, pack_count: 1)
    OrderLineItem.create(order_id: order.id, item_id: carmel_item.id, price_cents: 452, pack_weight_pounds: 435, pack_count: 1)
    OrderLineItem.create(order_id: order.id, item_id: mission_item.id, price_cents: 452, pack_weight_pounds: 10, pack_count: 10)
    OrderLineItem.create(order_id: order.id, item_id: mission_item.id, price_cents: 452, pack_weight_pounds: 2, pack_count: 10)
     
  end
  describe "#pounds" do 
    it "returns pounds in order" do 
      set_up_order
      chart = TotalPoundsChart.new
      expect(chart.pounds).to eq({"butte" => BigDecimal.new("1000.0"),
                                  "nonpariel" => BigDecimal.new("550.0"),
                                  "carmel" => BigDecimal.new("435.0"),
                                  "mission" => BigDecimal.new("100.0")})
    end

    it "sets the total pounds of each variety" do 
      set_up_order
      chart = TotalPoundsChart.new
      expect(chart.pounds["butte"]).to eq(BigDecimal.new("1000.0"))  
      expect(chart.pounds["nonpariel"]).to eq(BigDecimal.new("550.0"))  
      expect(chart.pounds["carmel"]).to eq(BigDecimal.new("435.0")) 
      expect(chart.pounds["mission"]).to eq(BigDecimal.new("100.0")) 
    end
  end

  describe "#chart_data" do 
    it "returns up to four varieties" do
      set_up_order
      chart = TotalPoundsChart.new
      expect(chart.chart_data.count).to eq(4)
    end
    it "calculates the percentage of the top for" do 
      require 'pry'; 

      set_up_order
      chart = TotalPoundsChart.new

      percent = 0
      chart.chart_data.each do |key, value|
        percent += value["percentage"]
      end
      expect(percent.to_i).to eq(100)
    end
  end

end

