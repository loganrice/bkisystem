require 'spec_helper'

Fabricator(:order_line_item) do 
  item_id { Fabricate(:item).id }
  price_cents { Faker::Number.number(10) }
  order_id { Fabricate(:order) }
end