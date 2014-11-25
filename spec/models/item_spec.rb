require 'spec_helper'

describe Item do
  it { should belong_to(:commodity) }
  it { should belong_to(:size) }
  it { should belong_to(:variety) }
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:commodity_id) }
end