class PackingListDoc < ShippingInstructionDoc 
  FILE_TEMPLATE_PATH = "#{Rails.root}/app/reports/packing_list.docx"

  def initialize(order)     
    super
  end

  def create_report
    @doc = DocxReplace::Doc.new(FILE_TEMPLATE_PATH, "#{Rails.root}/tmp")
    @doc.replace("[[SELLER_NAME]]", seller_name) 
    @doc.replace("[[S_LINE1]]", ensure_string(seller_address, :line1)) 
    @doc.replace("[[S_CITY]]", ensure_string(seller_address, :city)) 
    @doc.replace("[[S_STATE]]", ensure_string(seller_address, :state)) 
    @doc.replace("[[S_ZIP]]", ensure_string(seller_address, :zip)) 
    @doc.replace("[[PACKAGING]]", packaging_message)
    @doc.replace("[[CONTAINER_NUMBER]]", @order.container_number.to_s)
    @doc.replace("[[SELLER_CONTRACT]]", @order.contract.seller_contract.to_s)
    @doc.replace("[[LOAD]]", @order.row_on_contract.to_s)
    @doc.replace("[[BOOKING]]", @order.booking_number.to_s)
    @doc.replace("[[TOTAL_POUNDS]]", number_with_precision(@order.total_pounds.to_i, precision: 0, delimiter: ",", strip_insignificant_zeros: true))

    @doc.replace("[[GROSS_TRUCK_WEIGHT]]", number_with_precision(@order.gross_truck_weight.to_i, precision: 0, delimiter: ",", strip_insignificant_zeros: true))

    temp_file 
  end


  def packaging_message
    message = []
    uniq_items.each do |key, value|
      message << "#{value[:pack_count]} X #{value[:pack_weight]} Lb. #{value[:pack_type]} #{value[:commodity]}"
    end
    message.join(", ").squeeze(" ")
  end
end