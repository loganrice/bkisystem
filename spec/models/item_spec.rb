require 'spec_helper'

describe Item do
  it { should belong_to(:commodity) }
  it { should belong_to(:size) }
  it { should belong_to(:variety) }
  it { should belong_to(:grade) }
  it { should belong_to(:origin) }
  it { should belong_to(:shell) }
  it { should have_many(:quote_line_items)}
  it { should have_many(:order_line_items)}
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:commodity_id) }
  it { should validate_presence_of(:variety_id) }
  it { should validate_presence_of(:size_id) }
  it { should validate_presence_of(:grade_id) }
  it { should validate_presence_of(:origin)}
  
end