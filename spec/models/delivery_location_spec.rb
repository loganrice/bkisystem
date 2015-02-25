require 'spec_helper'

describe DeliveryLocation do
  it { should validate_presence_of :name } 
end