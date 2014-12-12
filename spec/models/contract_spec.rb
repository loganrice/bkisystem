require 'spec_helper'

describe Contract do 
  it { should belong_to(:buyer) }
  it { should belong_to(:seller) }
  it { should have_many(:shipments) }
  it { should accept_nested_attributes_for(:shipments) }
end