require 'spec_helper'

describe Commodity do
  it { should have_many(:items) }
  it { should validate_presence_of(:name) }
end