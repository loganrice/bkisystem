require 'spec_helper'

describe Document do 
  it { should have_many(:orders).through(:document_orders) }
  it { should validate_presence_of(:name) }
end