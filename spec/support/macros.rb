def set_current_user(user=nil)
  session[:user_id] = (user || Fabricate(:user)).id
end

def current_user
  User.find(session[:user_id])
end

def clear_current_user
  session[:user_id] = nil
end

def set_up_contract
  contract = Fabricate(:contract)
  order1 = Fabricate(:order, contract_id: contract.id, container_size: "40FCL")
  order2 = Fabricate(:order, contract_id: contract.id, container_size: "40FCL")
  buyer_address = Fabricate(:address)
  seller_address = Fabricate(:address)
  contract.seller.addresses << seller_address
  contract.buyer.addresses << buyer_address 

  size_indicator = ItemSizeIndicator.create(name: "AOL")
  nonpareil = Variety.create(name: "Nonpareil")
  almonds = Commodity.create(name: "Almonds")
  grade = Grade.create(name: "US Extra No. 1")
  size = Size.create(name: "22/24")
  origin = Origin.create(name: "California")
  lbs = Weight.create(weight_unit_of_measure: "Lbs")
  carton = PackType.create(name: "carton")
  item1 = Item.create(name: "Nonpariel Almonds US Extra No. 1 22/24", variety_id: nonpareil.id,
                        commodity_id: almonds.id, origin_id: origin.id, grade_id: grade.id, size_id: size.id)

  order1_line1 = Fabricate(:order_line_item, item_id: item1.id, order_id: order1.id, pack_weight_pounds: "500", pack_count: "10", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id)
  order1_line2 = Fabricate(:order_line_item, item_id: item1.id, order_id: order2.id, pack_weight_pounds: "500", pack_count: "10", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id)
  order2_line1 = Fabricate(:order_line_item, item_id: item1.id, order_id: order1.id, pack_weight_pounds: "100", pack_count: "5", item_size_indicator_id: size_indicator.id, weight_id: lbs.id, pack_type_id: carton.id)

  return contract
end