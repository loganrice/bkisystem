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
Variety.delete_all

almonds = Commodity.create(description: "Almonds")
walnuts = Commodity.create(description: "Walnuts")

a16a18 = Size.create(name: "16/18")
a18a20 = Size.create(name: "18/20")
a20a22 = Size.create(name: "20/22")
a22a24 = Size.create(name: "22/24")
a23a25 = Size.create(name: "23/25")
a24a26 = Size.create(name: "24/26")
a26a28 = Size.create(name: "26/28")
a27a30 = Size.create(name: "27/30")
a30a34 = Size.create(name: "30/34")
a34a40 = Size.create(name: "34/40")
a40a50 = Size.create(name: "40/50")
a50aaos = Size.create(name: "50 AOS")
inshell = Size.create(name: "inshell")
pieces = Size.create(name: "pieces")
uns = Size.create(name: "UNS")

nonpareil = Variety.create(name: "nonpareil")
butte = Variety.create(name: "butte")
carmel = Variety.create(name: "carmel")
fritz = Variety.create(name: "fritz")
mission = Variety.create(name: "mission")
monterey = Variety.create(name: "monterey")
padre = Variety.create(name: "padre")
peerless = Variety.create(name: "peerless")
price = Variety.create(name: "price")
sonora = Variety.create(name: "sonora")

item1 = Item.create(description: "Nonpareil 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id)
item2 = Item.create(description: "Nonpareil 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id)
item3 = Item.create(description: "Nonpareil 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id)
item4 = Item.create(description: "Nonpareil 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id)
item5 = Item.create(description: "Nonpareil 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: nonpareil.id)
item6 = Item.create(description: "Nonpareil 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: nonpareil.id)
item7 = Item.create(description: "Nonpareil 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: nonpareil.id)
item8 = Item.create(description: "Nonpareil 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: nonpareil.id)
item9 = Item.create(description: "Nonpareil 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: nonpareil.id)
item10 = Item.create(description: "Nonpareil 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: nonpareil.id)
Item.create(description: "Nonpareil 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: nonpareil.id)
Item.create(description: "butte 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: butte.id)
Item.create(description: "butte 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: butte.id)
Item.create(description: "butte 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: butte.id)
Item.create(description: "butte 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: butte.id)
Item.create(description: "butte 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: butte.id)
Item.create(description: "butte 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: butte.id)
Item.create(description: "butte 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: butte.id)
Item.create(description: "butte 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: butte.id)
Item.create(description: "butte 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: butte.id)
Item.create(description: "butte 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: butte.id)
Item.create(description: "butte 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: butte.id)







