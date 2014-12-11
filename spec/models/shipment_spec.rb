require 'spec_helper'

describe Shipment do 
  it { should belong_to(:contract) }
end