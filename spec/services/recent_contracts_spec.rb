require 'spec_helper'

describe RecentContracts do 

  let!(:last_3_days) { RecentContracts.new.last_3_days }

  describe "#last_3_days" do
    it "returns the last 3 days of contracts" do 
      contract1 = Fabricate(:contract, updated_at: Date.today)
      contract2 = Fabricate(:contract, updated_at: 1.days.ago)
      contract3 = Fabricate(:contract, updated_at: 3.days.ago)
      contract4 = Fabricate(:contract, updated_at: 19.days.ago)
      contract5 = Fabricate(:contract, updated_at: 35.days.ago)
      recent = RecentContracts.new.last_3_days 
      expect(recent.include?(contract1)).to be true
      expect(recent.include?(contract2)).to be true
      expect(recent.include?(contract3)).to be true
    end

    it "does not include contracts older than 3 days" do 
      contract1 = Fabricate(:contract, updated_at: Date.today)
      contract2 = Fabricate(:contract, updated_at: 1.days.ago)
      contract3 = Fabricate(:contract, updated_at: 3.days.ago)
      contract4 = Fabricate(:contract, updated_at: 19.days.ago)
      recent = RecentContracts.new.last_3_days
      expect(recent.include?(contract4)).to be false
    end
  end  
end