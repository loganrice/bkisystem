require 'spec_helper'

Fabricator(:container) do 
  item_id { Fabricate(:item).id }
  price_cents { Faker::Number.number(10) }
  
end