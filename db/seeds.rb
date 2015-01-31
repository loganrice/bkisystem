# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clear Table

require 'open-uri'
require 'csv'

Item.delete_all
Commodity.delete_all
Size.delete_all
Variety.delete_all
Contract.delete_all
Account.delete_all
Address.delete_all 
Order.delete_all
Quote.delete_all
OrderLineItem.delete_all
QuoteLineItem.delete_all
Weight.delete_all
User.delete_all
ItemSizeIndicator.delete_all
PackType.delete_all
Document.delete_all

almonds = Commodity.create(name: "Almonds")
walnuts = Commodity.create(name: "Walnuts")

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

fancy = Grade.create(name: "US Fancy", description: "US Fancy")
usno1 = Grade.create(name: "Extra No. 1", description: "US Extra No. 1")
sup = Grade.create(name: "SUP", description: "US No. 1 (Supreme")
ssr = Grade.create(name: "SSR", description: "US Select Sheller Run")
std = Grade.create(name: "Std 5%", description: "US Standard Sheller Run")
whole_broken = Grade.create(name: "Whole and Broken", description: "US No. 1 Whole & Broken")
pieces = Grade.create(name: "US No. 1 Pieces", description: "US No. 1 Pieces")

item1 = Item.create(name: "nonpareil 16/18 US Fancy", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id, grade_id: fancy.id )
item1a = Item.create(name: "nonpareil 16/18 Extra No. 1", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id, grade_id: usno1.id )
item1b = Item.create(name: "nonpareil 16/18 US No. 1 (Supreme)", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id, grade_id: sup.id )
item1c = Item.create(name: "nonpareil 16/18 US Select Sheller Run", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id, grade_id: ssr.id )
item1d = Item.create(name: "nonpareil 16/18 US Standard Sheller Run", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id, grade_id: std.id )
item1e = Item.create(name: "nonpareil 16/18 US No. 1 Whole & Broken", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id, grade_id: whole_broken.id)
item1f = Item.create(name: "nonpareil 16/18 US No. 1 Pieces", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id, grade_id: pieces.id )

item2 = Item.create(name: "nonpareil 18/20 US Fancy", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id, grade_id: fancy.id )
item2a = Item.create(name: "onpareil 18/20 Extra No. 1", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id, grade_id: usno1.id )
item2b = Item.create(name: "nonpareil 18/20 US No. 1 (Supreme)", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id, grade_id: sup.id )
item2c = Item.create(name: "nonpareil 18/20 US Select Sheller Run", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id, grade_id: ssr.id )
item2d = Item.create(name: "nonpareil 18/20 US Standard Sheller Run", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id, grade_id: std.id )
item2e = Item.create(name: "nonpareil 18/20 US No. 1 Whole & Broken", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id, grade_id: whole_broken.id)
item2f = Item.create(name: "nonpareil 18/20 US No. 1 Pieces", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id, grade_id: pieces.id )

item3 = Item.create(name: "nonpareil 20/22 US Fancy", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id, grade_id: fancy.id )
item3a = Item.create(name: "nonpareil 20/22 Extra No. 1", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id, grade_id: usno1.id )
item3b = Item.create(name: "nonpareil 20/22 US No. 1 (Supreme)", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id, grade_id: sup.id )
item3c = Item.create(name: "nonpareil 20/22 US Select Sheller Run", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id, grade_id: ssr.id )
item3d = Item.create(name: "nonpareil 20/22 US Standard Sheller Run", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id, grade_id: std.id )
item3e = Item.create(name: "nonpareil 20/22 US No. 1 Whole & Broken", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id, grade_id: whole_broken.id)
item3f = Item.create(name: "nonpareil 20/22 US No. 1 Pieces", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id, grade_id: pieces.id )

item4 = Item.create(name: "nonpareil 22/24 US Fancy", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id, grade_id: fancy.id )
item4a = Item.create(name: "nonpareil 22/24 Extra No. 1", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id, grade_id: usno1.id )
item4b = Item.create(name: "nonpareil 22/24 US No. 1 (Supreme)", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id, grade_id: sup.id )
item4c = Item.create(name: "nonpareil 22/24 US Select Sheller Run", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id, grade_id: ssr.id )
item4d = Item.create(name: "nonpareil 22/24 US Standard Sheller Run", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id, grade_id: std.id )
item4e = Item.create(name: "nonpareil 22/24 US No. 1 Whole & Broken", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id, grade_id: whole_broken.id)
item4f = Item.create(name: "nonpareil 22/24 US No. 1 Pieces", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id, grade_id: pieces.id )

item5 = Item.create(name: "nonpareil 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: nonpareil.id)
item6 = Item.create(name: "nonpareil 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: nonpareil.id)
item7 = Item.create(name: "nonpareil 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: nonpareil.id)
item8 = Item.create(name: "nonpareil 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: nonpareil.id)
item9 = Item.create(name: "nonpareil 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: nonpareil.id)
item10 = Item.create(name: "nonpareil 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: nonpareil.id)
Item.create(name: "nonpareil 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: nonpareil.id)

Item.create(name: "butte 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: butte.id)
Item.create(name: "butte 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: butte.id)
Item.create(name: "butte 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: butte.id)
Item.create(name: "butte 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: butte.id)
Item.create(name: "butte 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: butte.id)
Item.create(name: "butte 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: butte.id)
Item.create(name: "butte 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: butte.id)
Item.create(name: "butte 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: butte.id)
Item.create(name: "butte 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: butte.id)
Item.create(name: "butte 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: butte.id)
Item.create(name: "butte 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: butte.id)

Item.create(name: "carmel 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: carmel.id)
Item.create(name: "carmel 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: carmel.id)
Item.create(name: "carmel 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: carmel.id)
Item.create(name: "carmel 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: carmel.id)
Item.create(name: "carmel 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: carmel.id)
Item.create(name: "carmel 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: carmel.id)
Item.create(name: "carmel 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: carmel.id)
Item.create(name: "carmel 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: carmel.id)
Item.create(name: "carmel 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: carmel.id)
Item.create(name: "carmel 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: carmel.id)
Item.create(name: "carmel 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: carmel.id)

Item.create(name: "fritz 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: fritz.id)
Item.create(name: "fritz 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: fritz.id)
Item.create(name: "fritz 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: fritz.id)
Item.create(name: "fritz 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: fritz.id)
Item.create(name: "fritz 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: fritz.id)
Item.create(name: "fritz 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: fritz.id)
Item.create(name: "fritz 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: fritz.id)
Item.create(name: "fritz 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: fritz.id)
Item.create(name: "fritz 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: fritz.id)
Item.create(name: "fritz 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: fritz.id)
Item.create(name: "fritz 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: fritz.id)

Item.create(name: "mission 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: mission.id)
Item.create(name: "mission 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: mission.id)
Item.create(name: "mission 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: mission.id)
Item.create(name: "mission 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: mission.id)
Item.create(name: "mission 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: mission.id)
Item.create(name: "mission 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: mission.id)
Item.create(name: "mission 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: mission.id)
Item.create(name: "mission 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: mission.id)
Item.create(name: "mission 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: mission.id)
Item.create(name: "mission 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: mission.id)
Item.create(name: "mission 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: mission.id)

Item.create(name: "monterey 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: monterey.id)
Item.create(name: "monterey 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: monterey.id)
Item.create(name: "monterey 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: monterey.id)
Item.create(name: "monterey 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: monterey.id)
Item.create(name: "monterey 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: monterey.id)
Item.create(name: "monterey 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: monterey.id)
Item.create(name: "monterey 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: monterey.id)
Item.create(name: "monterey 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: monterey.id)
Item.create(name: "monterey 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: monterey.id)
Item.create(name: "monterey 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: monterey.id)
Item.create(name: "monterey 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: monterey.id)

Item.create(name: "padre 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: padre.id)
Item.create(name: "padre 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: padre.id)
Item.create(name: "padre 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: padre.id)
Item.create(name: "padre 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: padre.id)
Item.create(name: "padre 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: padre.id)
Item.create(name: "padre 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: padre.id)
Item.create(name: "padre 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: padre.id)
Item.create(name: "padre 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: padre.id)
Item.create(name: "padre 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: padre.id)
Item.create(name: "padre 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: padre.id)
Item.create(name: "padre 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: padre.id)

Item.create(name: "peerless 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: peerless.id)
Item.create(name: "peerless 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: peerless.id)
Item.create(name: "peerless 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: peerless.id)
Item.create(name: "peerless 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: peerless.id)
Item.create(name: "peerless 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: peerless.id)
Item.create(name: "peerless 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: peerless.id)
Item.create(name: "peerless 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: peerless.id)
Item.create(name: "peerless 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: peerless.id)
Item.create(name: "peerless 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: peerless.id)
Item.create(name: "peerless 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: peerless.id)
Item.create(name: "peerless 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: peerless.id)

Item.create(name: "price 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: price.id)
Item.create(name: "price 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: price.id)
Item.create(name: "price 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: price.id)
Item.create(name: "price 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: price.id)
Item.create(name: "price 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: price.id)
Item.create(name: "price 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: price.id)
Item.create(name: "price 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: price.id)
Item.create(name: "price 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: price.id)
Item.create(name: "price 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: price.id)
Item.create(name: "price 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: price.id)
Item.create(name: "price 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: price.id)

Item.create(name: "sonora 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: sonora.id)
Item.create(name: "sonora 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: sonora.id)
Item.create(name: "sonora 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: sonora.id)
Item.create(name: "sonora 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: sonora.id)
Item.create(name: "sonora 23/25", commodity_id: almonds.id, size_id: a23a25.id, variety_id: sonora.id)
Item.create(name: "sonora 24/26", commodity_id: almonds.id, size_id: a24a26.id, variety_id: sonora.id)
Item.create(name: "sonora 26/28", commodity_id: almonds.id, size_id: a26a28.id, variety_id: sonora.id)
Item.create(name: "sonora 27/30", commodity_id: almonds.id, size_id: a27a30.id, variety_id: sonora.id)
Item.create(name: "sonora 30/34", commodity_id: almonds.id, size_id: a30a34.id, variety_id: sonora.id)
Item.create(name: "sonora 34/40", commodity_id: almonds.id, size_id: a34a40.id, variety_id: sonora.id)
Item.create(name: "sonora 40/50", commodity_id: almonds.id, size_id: a40a50.id, variety_id: sonora.id)

nonpareil_inshell = Item.create(name: "nonpareil inshell", commodity_id: almonds.id, variety_id: nonpareil.id)


roche = Account.create(
  name: "Roche Brothers",
  phone1: "209-559-9000",
)

dynasty = Account.create(
  name: "Dynasty Universal Limited",
  phone1: "209-559-9000",
)

bki = Account.create(
  name: "BKI",
  phone1: "209-559-9000",
)

almond_ace = Account.create(
  name: "Almond Kings",
  phone1: "209-559-9000",
  phone2: "",
  fax: "209-599-9000",
  email: "miguel@almondkings.com",
  notes: "",
  bank_1_name: "Oak Valley Community Bank, 1000 Lion Ave, San Diego, CA 95000",
  bank_1_aba: "555552222",
  bank_1_account: "123412341234",
  bank_1_swift_code: "PCB153551",
  bank_1_attention: "Export Inc."
)

almond_ace.addresses.create(
  line1: "1555 Litt Road",
  line2: "",
  line3: "",
  city: "Sonora",
  state: "CA",
  zip: "95533",
  country: "USA"
)

almond_ace.banks.create(
  name: "Oak Valley Community Bank",
  aba: "1532",
  swift: "2325",
  attention: "Mike Smith"
)

nut_pros = Account.create(
  name: "Nut Pros",
  phone1: "209-559-9000",
  phone2: "",
  fax: "209-599-9000",
  email: "bob@nut_pros.com",
  notes: "",
  bank_1_name: "Oak Valley Community Bank, 1000 Lion Ave, San Diego, CA 95000",
  bank_1_aba: "555552222",
  bank_1_account: "123412341234",
  bank_1_swift_code: "PCB153551",
  bank_1_attention: "Export Inc."
)

almond_ace.addresses.create(
  line1: "1555 Litt Road",
  line2: "",
  line3: "",
  city: "Sonora",
  state: "CA",
  zip: "95533",
  country: "USA"
)

almond_ace.banks.create(
  name: "Oak Valley Community Bank",
  aba: "1532",
  swift: "2325",
  attention: "Mike Smith"
)

logan = User.create(name: "Logan Rice", email: "logan.rice@sigmagroup.solutions", password: "bki")
mark = User.create(name: "Mark Duroy", email: "mark.duroy@sigmagroup.solutions", password: "bki")
brad = User.create(name: "Brad Klump", email: "brad@bkiexports.com", password: "bki")
steve = User.create(name: "Steve Bava", email: "steve@bkiexports.com", password: "bki")
brad = User.create(name: "Jenny", email: "jenny@bkiexports.com", password: "bki")


kilograms = Weight.create(weight_unit_of_measure: "kgs")
pounds = Weight.create(weight_unit_of_measure: "lbs")

ItemSizeIndicator.create(name: "AOL", description: "and or larger")
ItemSizeIndicator.create(name: "SC", description: "Straight Count")
ItemSizeIndicator.create(name: "-", description: "-")
ItemSizeIndicator.create(name: "|", description: "|")

PackType.create(name: "Bin")
PackType.create(name: "Carton")
PackType.create(name: "Bags")
PackType.create(name: "Big Bags")
PackType.create(name: "b/ss")


a14_193 = Contract.create(buyer_id: dynasty.id, seller_id: roche.id, date: Date.new(2014,12,22))
a14_193_load_1 = Order.create(contract_id: a14_193.id)
a14_193_commission = Commission.create(cents_per_pound: 3, order_id: a14_193_load_1.id, broker_id: bki.id)
a14_193_load_1_line_1 = OrderLineItem.create(
  order_id: a14_193_load_1.id, 
  item_id: nonpareil_inshell.id,
  weight_id: pounds.id,
  pack_weight_pounds: 50,
  pack_count: 900,
  price_cents: 316)


Document.create(name: "Fumigation Certificate")
Document.create(name: "Aflaxtoxin Certificate")
Document.create(name: "Certificate of Origin")
Document.create(name: "USDA / DFA")
Document.create(name: "Weight Certificate")
Document.create(name: "QC Certification")
Document.create(name: "Phytosanitary Certificate")
Document.create(name: "No Wood Certificate")
Document.create(name: "Salmonella")
Document.create(name: "Production and Expiration")
Document.create(name: "Clean Container Certificate")
Document.create(name: "GMO Statement")
Document.create(name: "Health Certificate")
Document.create(name: "VASP")
Document.create(name: "Certificate of Analysis")
Document.create(name: "Wooden Pallet Certificate")
Document.create(name: "Chamber Certificate of Origin")
Document.create(name: "Truck Bill of Lading")
Document.create(name: "Pesticide Cert")
Document.create(name: "Ocean Bill of Lading")
Document.create(name: "Canadian Invoice")
Document.create(name: "Canadian Load Lock Form")
Document.create(name: "Price List")
Document.create(name: "EU Pallet Cert")























