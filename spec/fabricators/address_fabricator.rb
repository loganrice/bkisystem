Fabricator(:address) do 
  line1 { Faker::Address.street_address }
  line2 { Faker::Address.secondary_address }
  line3 { Faker::Address.building_number }
  city { Faker::Address.city }
  state { Faker::Address.state }
  zip { Faker::Address.postcode }
end