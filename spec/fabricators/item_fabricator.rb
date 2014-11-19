Fabricator(:item) do 
  description { Faker::Lorem.words(5).join(" ") }
end