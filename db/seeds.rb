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
Grade.delete_all
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
Origin.delete_all
Invoice.delete_all
InvoiceLineItem.delete_all
Term.delete_all
Remark.delete_all

almonds = Commodity.create(name: "Almonds")
walnuts = Commodity.create(name: "Walnuts")
california = Origin.create(name: "California")

def sizes
  sizes = []
  sizes << Size.create(name: "16/18")
  sizes << Size.create(name: "18/20")
  sizes << Size.create(name: "20/22")
  sizes << Size.create(name: "22/24")
  sizes << Size.create(name: "23/25")
  sizes << Size.create(name: "24/26")
  sizes << Size.create(name: "26/28")
  sizes << Size.create(name: "27/30")
  sizes << Size.create(name: "30/34")
  sizes << Size.create(name: "34/40")
  sizes << Size.create(name: "40/50")
  sizes << Size.create(name: "50 AOS")
  sizes << Size.create(name: "inshell")
  sizes << Size.create(name: "pieces")
  sizes << Size.create(name: "UNS")
end

def grades
  grades = []
  grades << Grade.create(name: "US Fancy", description: "US Fancy")
  grades << Grade.create(name: "Extra No. 1", description: "US Extra No. 1")
  grades << Grade.create(name: "SUP", description: "US No. 1 (Supreme")
  grades << Grade.create(name: "SSR", description: "US Select Sheller Run")
  grades << Grade.create(name: "Std 5%", description: "US Standard Sheller Run")
  grades << Grade.create(name: "Whole and Broken", description: "US No. 1 Whole & Broken")
  grades << Grade.create(name: "US No. 1 Pieces", description: "US No. 1 Pieces")
  grades
end

def varieties
  varieties = []
  varieties << Variety.create(name: "nonpareil")
  varieties << Variety.create(name: "butte")
  varieties << Variety.create(name: "carmel")
  varieties << Variety.create(name: "fritz")
  varieties << Variety.create(name: "mission")
  varieties << Variety.create(name: "monterey")
  varieties << Variety.create(name: "padre")
  varieties << Variety.create(name: "peerless")
  varieties << Variety.create(name: "price")
  varieties << Variety.create(name: "sonora")
  varieties
end

varieties.each do |variety|
  sizes.each do |size|
    grades.each do |grade|
      Item.create(name: "#{variety.name} #{size.name} #{grade.name}", commodity_id: almonds.id, origin_id: california.id, size_id: size.id, variety_id: variety.id, grade_id: grade.id)
    end
  end
end


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

def generate_random_string
  (0...8).map { (65 + rand(26)).chr }.join
end

a14_193 = Contract.create(buyer_id: dynasty.id, seller_id: roche.id, date: Date.new(2014,12,22), seller_contract: generate_random_string)
a14_193_load_1 = Order.create(contract_id: a14_193.id)
a14_193_commission = Commission.create(cents_per_pound: 3, order_id: a14_193_load_1.id, broker_id: bki.id)
a14_193_load_1_line_1 = OrderLineItem.create(
  order_id: a14_193_load_1.id, 
  item_id: Item.first.id,
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
Document.create(name: "Packing Certificate")


Term.create(name: "Cash against documents upon first sight...", description: "Cash against documents upon first sight, through buyers bank. Other freight and insurance for buyers account. Transfer cost and bank fees for payment for buyer account.")
Term.create(name: "TT", description: "Cash - T/T against faxed documents 5 days prior to vessel arrival. Once payment is received documents sent directly to buyer.")
Term.create(name: "30 Days", description: "30 Days From Truck Bill of Lading / Ship Date.")
Term.create(name: "45 Days", description: "45 Days From Truck Bill of Lading / Ship Date.")

Remark.create(name: "UAEC terms and conditions. Quality certificate...", description: "UAEC terms and conditions. Quality and Weight certificates are required and are final as to quality and weight. ")
Remark.create(name: "Sliding Scale Inshell", description: "UAEC terms and conditions. Quality and Weight certificates are required and are final as to quality and weight. Price will be determined by USDA or DFA certificate to determine sliding scale for meat basis.")
Remark.create(name: "CERT TO STATE", description: "UAEC terms and conditions. Quality and Weight certificates are required and are final as to quality and weight. Price will be determined by USDA or DFA certificate to determine sliding scale for meat basis. USDA Cert to state the % of external/internal defect and % of loose meat.")
Remark.create(name: "Shing Hing", description: "UAEC terms and conditions. Quality and Weight certificates are required and are final as to quality and weight. Price is based on 70% sliding scale, Minimum 68%, Maximum payable 72%. Price will be determined by USDA or DFA certificate to determine sliding scale for meat basis. USDA Cert to state the % of external/internal defect and % of loose meat. Max 2% Loose Meats. Packed in plain bags.")
Remark.create(name: "SCTC", description: "SCTC terms and conditions. Quality and Weight certificates are required and are final as to quality and weight.")


















