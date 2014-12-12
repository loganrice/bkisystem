require 'spec_helper'

describe Shipment do 
  it { should belong_to(:contract) }
  it { should have_many(:containers) }
  it "sort containers descending order by creation date" do 
    shipment = Fabricate(:shipment)
    month_ago = Fabricate(:container, created_at: 1.month.ago, shipment_id: shipment.id)
    hour_ago = Fabricate(:container, created_at: 1.hour.ago, shipment_id: shipment.id)
    day_ago = Fabricate(:container, created_at: 1.day.ago, shipment_id: shipment.id)
    shipment.reload
    expect(shipment.containers).to eq([hour_ago, day_ago, month_ago])

  end
  
end