class ShippingInstruction
  include DocxReplace

  def initialize(order)
    @doc = DocxReplace::Doc.new("#{Rails.root}/app/reports/shipping_instructions.docx", "#{Rails.root}/tmp")
    @order = order 
    create_shipping_report
  end

  def create_shipping_report
    @doc.replace( "[[SHIP_DATE]]", ship_date)
    @doc.replace("[[SELLER_CONTRACT]]", seller_contract)
    @doc.replace("[[LOAD_NUMBER]]", load_number)
    @doc.replace("[[BUYER_CONTRACT]]", buyer_contract)
    @doc.replace("[[SELLER_NAME]]", seller_name)
    @doc.replace("[[SELLER_LINE1]]", seller_address_line1)
    @doc.replace("[[SELLER_CITY]]", seller_address_city)
    @doc.replace("[[SELLER_STATE]]", seller_address_state)
    @doc.replace("[[SELLER_ZIP]]", seller_address_zip)
    @doc.replace("[[BUYER_NAME]]", buyer_name)
    @doc.replace("[[BLINE1]]", buyer_address_line1)
    @doc.replace("[[BCTY]]", buyer_address_city)
    @doc.replace("[[BST]]", buyer_address_state)
    @doc.replace("[[BZIP]]", buyer_address_zip)

    @doc.replace("[[CONSIGNEE]]", consignee)
    @doc.replace("[[CLINE1]]", line1)
    @doc.replace("[[CCITY]]", city)
    @doc.replace("[[CST]]", state)
    @doc.replace("[[CZIP]]", zip)
    @doc.replace("[[CONTAINER]]", container)
    @doc.replace("[[LOAD_COUNT]]", load_count)
    @doc.replace("[[SHIP_CO]]", shipping_company)
    @doc.replace("[[VESSEL]]", vessel)
    @doc.replace("[[VOYAGE]]", voyage)
    @doc.replace("[[BOOKING]]", booking_number)
    @doc.replace("[[LST_DATE]]", last_received_date)
    @doc.replace("[[CUT_OFF]]", doc_cut_off)
    @doc.replace("[[ARRIVE_DATE]]", estimated_arrival_date)
    @doc.replace("[[PRT_DISCHRG]]", port)
    @doc.replace("[[SHIP_PICK_UP]]", ship_pick_up)
    @doc.replace("[[SHIP_DELIVERY]]", ship_delivery)
    @doc.replace("[[DOCUMENTS]]", documents)
    @doc.replace("[[MAIL_TO]]", mail_to)
    @doc.replace("[[MAIL_LINE1]]", mail_to_line1)
    @doc.replace("[[MAIL_CITY]]", mail_to_city)
    @doc.replace("[[MAIL_STATE]]", mail_to_state)
    @doc.replace("[[MAIL_ZIP]]", mail_to_zip)
    @doc.replace("[[SHIPPING_INSTRUCTIONS]]", shipping_instructions)
    item_detail
    temp_file
  end 

  def ship_date
    @order.ship_date.to_s rescue ""
  end

  def seller_contract
    @order.contract.seller_contract rescue ""
  end

  def load_number
    @order.row_on_contract.to_s rescue ""
  end

  def buyer_contract
    @order.contract.buyer_contract rescue ""
  end

  def seller_name
    @order.contract.seller.name rescue ""
  end

  def buyer_name
    @order.contract.buyer.name rescue ""
  end

  def seller_address_line1
    @order.contract.seller.addresses.first.line1 rescue ""
  end

  def buyer_address_line1
    @order.contract.buyer.addresses.first.line1 rescue ""
  end

  def seller_address_city
    "#{@order.contract.seller.addresses.first.city},"rescue ""
  end
  
  def buyer_address_city
    "#{@order.contract.buyer.addresses.first.city}," rescue ""
  end

  def seller_address_state
    @order.contract.seller.addresses.first.state rescue ""
  end

  def buyer_address_state
    @order.contract.buyer.addresses.first.state rescue ""
  end

  def seller_address_zip
    @order.contract.seller.addresses.first.zip rescue ""
  end

  def buyer_address_zip
    @order.contract.buyer.addresses.first.zip rescue ""
  end

  def consignee
    @order.consignee rescue ""
  end

  def line1
    @order.line1 rescue ""
  end

  def city
    "#{@order.city}," rescue ""
  end

  def state
    @order.state rescue ""
  end

  def zip
    @order.zip rescue ""
  end

  def container
    @order.container_size rescue ""
  end

  def load_count
    @order.contract.orders.count rescue ""
  end

  def temp_file
    # Write the document back to a temporary file
    tmp_file = Tempfile.new('word_tempate', "#{Rails.root}/tmp")
    @doc.commit(tmp_file.path)
    return tmp_file.path 
  end

  def item_detail
    @order.order_line_items.each_with_index do |line_item, index|
      @doc.replace("[[PACK_COUNT#{index}]]", line_item.pack_count)
      @doc.replace("[[PACK_WEIGHT#{index}]]", line_item.pack_weight_pounds)
      @doc.replace("[[PACK_TYPE#{index}]]", line_item.pack_type.name)
      @doc.replace("[[ITEM#{index}]]", line_item.item.name)

    end
  end

  def shipping_company
    @order.shipping_company rescue ""
  end

  def vessel
    @order.vessel rescue ""
  end

  def voyage
    @order.voyage rescue ""
  end

  def booking_number
    @order.booking_number rescue ""
  end

  def port
    @order.port_of_discharge
  end

  def last_received_date
    @order.last_received_date.strftime("%m/%d/%Y") rescue ""
  end

  def doc_cut_off
    @order.doc_cut_off.strftime("%m/%d/%Y") rescue ""
  end

  def estimated_arrival_date
    @order.estimated_arrival_date.strftime("%m/%d/%Y") rescue ""
  end

  def ship_pick_up
    @order.ship_pick_up rescue ""
  end

  def ship_delivery
    @order.ship_delivery rescue ""
  end

  def documents
    docs = @order.documents.map { |document| document.name }
    docs.join(", ")
  end

  def mail_to
    @order.mail_to.name rescue ""
  end

  def mail_to_line1
    @order.mail_to.addresses.first.line1 rescue ""
  end

  def mail_to_city
    @order.mail_to.addresses.first.city rescue ""
  end

  def mail_to_state
    @order.mail_to.addresses.first.state rescue ""
  end

  def mail_to_zip
    @order.mail_to.addresses.first.zip rescue ""
  end

  def shipping_instructions
    @order.shipping_instructions rescue ""
  end
end