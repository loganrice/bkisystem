class CertificateOfOriginDoc < ShippingInstructionDoc 
  FILE_TEMPLATE_PATH = "#{Rails.root}/app/reports/certificate_of_origin.docx"

  def initialize(order)     
    super
    @certificate_of_origin = @order.certificate_of_origin 
  end

  def create_report
    @doc = DocxReplace::Doc.new(FILE_TEMPLATE_PATH, "#{Rails.root}/tmp")
    @doc.replace("[[SELLER_NAME]]", seller_name) # appears 3 times in template
    @doc.replace("[[SELLER_NAME]]", seller_name)  
    @doc.replace("[[SELLER_NAME]]", seller_name)  

    @doc.replace("[[S_LINE1]]", ensure_string(seller_address, :line1)) # appears 2 times in template
    @doc.replace("[[S_LINE1]]", ensure_string(seller_address, :line1))

    @doc.replace("[[S_CITY]]", ensure_string(seller_address, :city)) # appears 2 times in template
    @doc.replace("[[S_CITY]]", ensure_string(seller_address, :city))

    @doc.replace("[[S_STATE]]", ensure_string(seller_address, :state)) # appears 2 times in template
    @doc.replace("[[S_STATE]]", ensure_string(seller_address, :state))

    @doc.replace("[[S_ZIP]]", ensure_string(seller_address, :zip)) # appears 2 times in template
    @doc.replace("[[S_ZIP]]", ensure_string(seller_address, :zip))

    @doc.replace("[[SELLER_CONTRACT]]", seller_contract)
    @doc.replace("[[SELLER_CONTRACT]]", seller_contract) # appears two times in template
    @doc.replace("[[BOOKING]]", booking_number)
    @doc.replace("[[CONSIGNEE]]", consignee)
    @doc.replace("[[C_LINE1]]", line1)
    @doc.replace("[[C_CITY]]", city)
    @doc.replace("[[C_STATE]]", state)
    @doc.replace("[[C_ZIP]]", zip)
    # consignee section appears two times in template
    @doc.replace("[[CONSIGNEE]]", consignee)
    @doc.replace("[[C_LINE1]]", line1)
    @doc.replace("[[C_CITY]]", city)
    @doc.replace("[[C_STATE]]", state)
    @doc.replace("[[C_ZIP]]", zip)
    @doc.replace("[[AGENT]]", @certificate_of_origin.try(:forwarding_agent).to_s)
    @doc.replace("[[TREATMENT]]", @certificate_of_origin.try(:treatment).to_s)
    @doc.replace("[[INSTRUCTIONS]]", @certificate_of_origin.try(:routing_instructions).to_s)
    @doc.replace("[[CARRIAGE]]", @certificate_of_origin.try(:initial_carriage_by).to_s)
    @doc.replace("[[PLACE]]", @certificate_of_origin.try(:place_of_initial_receipt).to_s)
    @doc.replace("[[SHIP_DATE]]", @order.try(:ship_date).to_s)
    @doc.replace("[[PORT_OF_DISCHARGE]]", @order.try(:port_of_discharge).to_s)
    @doc.replace("[[PORT_OF_DISCHARGE]]", @order.try(:port_of_discharge).to_s) # appears twice
    @doc.replace("[[VESSEL]]", @certificate_of_origin.try(:vessel).to_s)
    @doc.replace("[[PORT_LOADING]]", @certificate_of_origin.try(:port_of_loading).to_s)
    @doc.replace("[[CONTAINER_NUMBER]]", @order.try(:container_number).to_s)
    @doc.replace("[[INVOICE]]", @order.try(:invoice_number).to_s)

    @doc.replace("[[DOC_CUT]]", @order.try(:doc_cut_off).to_s)
    @doc.replace("[[PACKAGING]]", packaging_message)
    @doc.replace("[[WEIGHT]]", number_with_precision(@order.total_pounds, precision: 0, delimiter: ",", strip_insignificant_zeros: true))
    @doc.replace("[[GROSS_WEIGHT]]", number_with_precision(@order.gross_weight, precision: 0, delimiter: ",", strip_insignificant_zeros: true))

    temp_file 
  end

  def address(address_object)
    
  end



  def packaging_message
    message = []
    uniq_items.each do |key, value|
      message << "#{value[:pack_count]} X #{value[:pack_weight]} Lb. #{value[:pack_type]} #{value[:commodity]}"
    end
    message.join(", ").squeeze(" ")
  end
end
