Fabricator(:quote_line_item) do 
  price_cents { Faker::Number.number(12) }
  item_id { Fabricate(:item).id }
end