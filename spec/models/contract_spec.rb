require 'spec_helper'

describe Contract do 
  it { should belong_to(:buyer) }
  it { should belong_to(:seller) }
end