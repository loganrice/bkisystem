# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

# Clear Table

require 'faker'
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

item1 = Item.create(name: "nonpareil 16/18", commodity_id: almonds.id, size_id: a16a18.id, variety_id: nonpareil.id)
item2 = Item.create(name: "nonpareil 18/20", commodity_id: almonds.id, size_id: a18a20.id, variety_id: nonpareil.id)
item3 = Item.create(name: "nonpareil 20/22", commodity_id: almonds.id, size_id: a20a22.id, variety_id: nonpareil.id)
item4 = Item.create(name: "nonpareil 22/24", commodity_id: almonds.id, size_id: a22a24.id, variety_id: nonpareil.id)
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

contract_1 = Contract.create(buyer_contract: Faker::Number.number(4), buyer_po: Faker::Number.number(6), seller_contract: Faker::Number.number(7), date: Faker::Date.between(30.days.ago, Date.today))
contract_2 = Contract.create(buyer_contract: Faker::Number.number(4), buyer_po: Faker::Number.number(6), seller_contract: Faker::Number.number(7), date: Faker::Date.between(30.days.ago, Date.today))
contract_3 = Contract.create(buyer_contract: Faker::Number.number(4), buyer_po: Faker::Number.number(6), seller_contract: Faker::Number.number(7), date: Faker::Date.between(30.days.ago, Date.today))
contract_4 = Contract.create(buyer_contract: Faker::Number.number(4), buyer_po: Faker::Number.number(6), seller_contract: Faker::Number.number(7), date: Faker::Date.between(30.days.ago, Date.today))
contract_5 = Contract.create(buyer_contract: Faker::Number.number(4), buyer_po: Faker::Number.number(6), seller_contract: Faker::Number.number(7), date: Faker::Date.between(30.days.ago, Date.today))
contract_6 = Contract.create(buyer_contract: Faker::Number.number(4), buyer_po: Faker::Number.number(6), seller_contract: Faker::Number.number(7), date: Faker::Date.between(30.days.ago, Date.today))
contract_7 = Contract.create(buyer_contract: Faker::Number.number(4), buyer_po: Faker::Number.number(6), seller_contract: Faker::Number.number(7), date: Faker::Date.between(30.days.ago, Date.today))
contract_3.quotes.create()
contract_4.quotes.create()
contract_5.quotes.create()
contract_6.quotes.create()
contract_7.quotes.create()
contract_3.orders.create()
contract_4.orders.create()
contract_5.orders.create()
contract_6.orders.create()
contract_7.orders.create()


quote_1 = Quote.create(contract_id: contract_1.id)
quote_2 = Quote.create(contract_id: contract_2.id)

order_1 = Order.create(contract_id: contract_1.id)
order_2 = Order.create(contract_id: contract_2.id)

quote_line_item_1 = QuoteLineItem.create(item_id: Item.first.id, quote_id: quote_1.id, price_cents: 13559, weight_grams: 1000 )
quote_line_item_2 = QuoteLineItem.create(item_id: Item.last.id, quote_id: quote_2.id, price_cents: 55555, weight_grams: 2000 )

order_line_item_1 = OrderLineItem.create(order_id: order_1.id, quote_line_item_id: quote_line_item_1, weight_grams: 500)
order_line_item_2 = OrderLineItem.create(order_id: order_2.id, quote_line_item_id: quote_line_item_2, weight_grams: 1000)

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

logan = User.create(name: "Logan Rice", email: "logan.rice@sigmagroup.solutions", password: "bki")
mark = User.create(name: "Mark Duroy", email: "mark.duroy@sigmagroup.solutions", password: "bki")
brad = User.create(name: "Brad Klump", email: "brad@bkiexports.com", password: "bki")
steve = User.create(name: "Steve Bava", email: "steve@bkiexports.com", password: "bki")
brad = User.create(name: "Jenny", email: "jenny@bkiexports.com", password: "bki")


Weight.create(weight_unit_of_measure: "kilograms")
Weight.create(weight_unit_of_measure: "pounds")



