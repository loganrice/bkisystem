require 'spec_helper'

describe Term do 
  it { should validate_presence_of(:name) }
end