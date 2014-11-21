# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clear Table
Item.delete_all
Commodity.delete_all
Size.delete_all

almonds = Commodity.create(description: "Almonds")
walnuts = Commodity.create(description: "Walnuts")

Size.create(name: "16/18")
Size.create(name: "18/20")
Size.create(name: "20/22")
Size.create(name: "22/24")
Size.create(name: "23/25")
Size.create(name: "24/26")
Size.create(name: "26/28")
Size.create(name: "27/30")
Size.create(name: "30/34")
Size.create(name: "34/40")
Size.create(name: "40/50")
Size.create(name: "50 AOS")
Size.create(name: "inshell")
Size.create(name: "pieces")
Size.create(name: "UNS")

item1 = Item.create(description: "Nonpareil U.S. Fancy 16/18", commodity_id: almonds.id)
item2 = Item.create(description: "Nonpareil U.S. Fancy 18/20", commodity_id: almonds.id)
item3 = Item.create(description: "Nonpareil U.S. Fancy 20/22", commodity_id: almonds.id)
item4 = Item.create(description: "Nonpareil U.S. Fancy 22/24", commodity_id: almonds.id)
item5 = Item.create(description: "Nonpareil U.S. Fancy 23/25", commodity_id: almonds.id)
item6 = Item.create(description: "Nonpareil U.S. Fancy 24/26", commodity_id: almonds.id)
item7 = Item.create(description: "Nonpareil U.S. Fancy 26/28", commodity_id: almonds.id)
item8 = Item.create(description: "Nonpareil U.S. Fancy 27/30", commodity_id: almonds.id)
item9 = Item.create(description: "Nonpareil U.S. Fancy 30/34", commodity_id: almonds.id)
item10 = Item.create(description: "Nonpareil U.S. Fancy 34/40", commodity_id: almonds.id)
item11 = Item.create(description: "Nonpareil U.S. Fancy 40/50", commodity_id: almonds.id)
item12 = Item.create(description: "Nonpareil U.S. Standard Sheller Run 16/18", commodity_id: almonds.id)
item13 = Item.create(description: "Nonpareil U.S. Standard Sheller Run 18/20", commodity_id: almonds.id)
item14 = Item.create(description: "Nonpareil U.S. Standard Sheller Run 20/22", commodity_id: almonds.id)
item15 = Item.create(description: "Nonpareil U.S. Standard Sheller Run 22/24", commodity_id: almonds.id)
item16 = Item.create(description: "Nonpareil U.S. Standard Sheller Run 23/25", commodity_id: almonds.id)

