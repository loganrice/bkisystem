Fabricator(:contract) do 
  buyer_contract { Faker::Number.number(10) }
  buyer_po { Faker::Number.number(10) }
  seller_contract { Faker::Number.number(10) }
  date { Faker::Date.between(30.days.ago, Date.today) }
end