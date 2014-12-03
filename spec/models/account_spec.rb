require 'spec_helper'

describe Account do
  it { should validate_presence_of(:name) }
  it { should have_many(:addresses) }
  it { should accept_nested_attributes_for(:addresses) }
end