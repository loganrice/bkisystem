class ShippingInstructionDoc
  include DocxReplace

  def initialize(order)
    @doc = DocxReplace::Doc.new("#{Rails.root}/app/reports/shipping_instructions.docx", "#{Rails.root}/tmp")
    @order = order
    @contract = @order.contract
    create_shipping_report
  end

  def create_shipping_report
    @doc.replace( "[[SHIP_DATE]]", ship_date)
    @doc.replace("[[SELLER_CONTRACT]]", seller_contract)
    @doc.replace("[[LOAD_NUMBER]]", load_number)
    @doc.replace("[[BUYER_CONTRACT]]", buyer_contract)
    @doc.replace("[[SELLER_NAME]]", seller_name)
    @doc.replace("[[SELLER_LINE1]]", ensure_string(seller_address, :line1))
    @doc.replace("[[SELLER_CITY]]", ensure_string(seller_address, :city))
    @doc.replace("[[SELLER_STATE]]", ensure_string(seller_address, :state))
    @doc.replace("[[SELLER_ZIP]]", ensure_string(seller_address, :zip))
    @doc.replace("[[BUYER_NAME]]", buyer_name)
    @doc.replace("[[BLINE1]]", ensure_string(buyer_address, :line1))
    @doc.replace("[[BCTY]]", ensure_string(buyer_address, :city))
    @doc.replace("[[BST]]", ensure_string(buyer_address, :state))
    @doc.replace("[[BZIP]]", ensure_string(buyer_address, :zip))
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
    @doc.replace("[[MAIL_LINE1]]", ensure_string(mail_to_address, :line1))
    @doc.replace("[[MAIL_CITY]]", ensure_string(mail_to_address, :city))
    @doc.replace("[[MAIL_STATE]]", ensure_string(mail_to_address, :state))
    @doc.replace("[[MAIL_ZIP]]", ensure_string(mail_to_address, :zip))
    @doc.replace("[[SHIPPING_INSTRUCTIONS]]", shipping_instructions)
    @doc.replace("[[ORIGIN_SHELL_COMMODITY]]", origin_shell_commodity)
    @doc.replace("[[ITEM_DETAILS]]", item_details)

    
    temp_file
  end 

  def ship_date
    @order.ship_date.to_s
  end

  def seller_contract
    @contract.seller_contract.to_s
  end

  def load_number
    @order.row_on_contract.to_s
  end

  def buyer_contract
    @contract.buyer_contract.to_s
  end

  def seller_name
    @contract.seller.name.to_s 
  end

  def buyer_name
    @contract.buyer.name.to_s 
  end

  def buyer_address
    return @buyer_address if defined? @buyer_address
    @buyer_address = @order.contract.buyer.try(:addresses).try(:first)
  end

  def seller_address
    return @seller_address if defined? @seller_address
    @seller_address = @order.contract.seller.try(:addresses).try(:first)
  end


  def mail_to_address
    return @mail_to_address if defined? @mail_to_address
    @mail_to_address = @order.mail_to.try(:addresses).try(:first)
  end

  def ensure_string(object, method)
    object.try(method) || ""
  end

  def consignee
    @order.consignee.to_s 
  end

  def line1
    @order.line1.to_s 
  end

  def city
    @order.city.to_s 
  end

  def state 
    @order.state.to_s
  end

  def zip
    @order.zip.to_s
  end

  def container
    @order.container_size.to_s 
  end

  def load_count
    @contract.orders.count.to_s 
  end

  def temp_file
    # Write the document back to a temporary file
    tmp_file = Tempfile.new('word_tempate', "#{Rails.root}/tmp")
    @doc.commit(tmp_file.path)
    return tmp_file.path 
  end

  def item_details 
    @order.order_line_items.map { |line_item|
      [line_item.pack_count, "X #{line_item.pack_weight_pounds} Lb", line_item.pack_type.name, line_item.item.name].join(' ')
    }.join("</w:t><w:br/><w:t>")
  end

  def origin_shell_commodity
    @order.order_line_items.map { |line_item|
      [line_item.item.origin.try(:name), line_item.item.shell.try(:name), line_item.item.commodity.try(:name)].join(' ')
    }.uniq.join(", ")
  end

  def shipping_company
    @order.shipping_company.to_s 
  end

  def vessel
    @order.vessel.to_s 
  end

  def voyage
    @order.voyage.to_s 
  end

  def booking_number
    @order.booking_number.to_s 
  end

  def port
    @order.port_of_discharge.to_s 
  end

  def last_received_date
    @order.last_received_date.try(:strftime, "%m/%d/%Y") || ""
  end

  def doc_cut_off
    @order.doc_cut_off.try(:strftime, "%m/%d/%Y") || ""
  end

  def estimated_arrival_date
    @order.estimated_arrival_date.try(:strftime, "%m/%d/%Y") || ""
  end

  def ship_pick_up
    @order.ship_pick_up.to_s 
  end

  def ship_delivery
    @order.ship_delivery.to_s 
  end

  def documents
    @order.documents.map(&:name).join(", ")
  end

  def mail_to
    @order.mail_to.name.to_s 
  end


  def shipping_instructions
    @order.shipping_instructions.to_s 
  end

  def origin
    origins = @order.order_line_items.map { |line_item| line_item.try(:item).try(:origin).try(:name) }
    origins.exclude? "NA" 
    origins.uniq.join(", ")
  end

  def commodity
    @order.order_line_items.first.item.commodity.name rescue ""
  end
end