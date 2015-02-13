Fabricator(:bank) do 
  name { Faker::Company.name }
  aba { Faker::Number.number(10).to_s }
  swift { Faker::Number.number(10).to_s }
  attention { Faker::Name.name }

end
