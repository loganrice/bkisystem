require 'spec_helper'

describe Shell do 
  it { should have_many(:items) }
  it { should validate_presence_of(:name) }
end