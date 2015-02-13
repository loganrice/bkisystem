Fabricator(:account) do 
  name { Faker::Company.name }
  phone1 { Faker::PhoneNumber.phone_number }
  phone2 { Faker::PhoneNumber.phone_number }
  fax { Faker::PhoneNumber.phone_number }
  first_name { Faker::Name.first_name }
  last_name { Faker::Name.last_name }
  email { Faker::Internet.email }
  address_1_line_1 { Faker::Address.street_address }
  address_1_line_2 { Faker::Address.secondary_address }
  address_1_line_3 { Faker::Address.building_number }
  address_1_city { Faker::Address.city }
  address_1_state { Faker::Address.state }
  address_1_zip { Faker::Address.zip }
  address_1_country { Faker::Address.country }
  notes { Faker::Lorem.paragraph(2).to_s }
  bank_1_name { Faker::Company.name }
  bank_1_aba { Faker::Number.number(10) }
  bank_1_account { Faker::Number.number(6) }
  bank_1_swift_code { Faker::Number.number(12) }
  bank_1_attention { Faker::Name.name }

end