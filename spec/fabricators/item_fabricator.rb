Fabricator(:item) do 
  name { Faker::Lorem.words(5).join(" ") }
  commodity { Fabricate(:commodity)}
  size { Fabricate(:size) }
  variety { Fabricate(:variety) }
end