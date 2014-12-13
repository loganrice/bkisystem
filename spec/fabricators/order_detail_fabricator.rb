require 'spec_helper'

Fabricator(:order_detail) do 
  item_id { Fabricate(:item).id }
  price_cents { Faker::Number.number(10) }
  
end