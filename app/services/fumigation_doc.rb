class FumigationDoc < ShippingInstructionDoc 
  FILE_TEMPLATE_PATH = "#{Rails.root}/app/reports/fumigation.docx"

  def initialize(order)     
    super
  end

  def create_report
    @doc = DocxReplace::Doc.new(FILE_TEMPLATE_PATH, "#{Rails.root}/tmp")
    @doc.replace("[[SELLER_NAME]]", seller_name) 
    @doc.replace("[[S_LINE1]]", ensure_string(seller_address, :line1)) 
    @doc.replace("[[S_CITY]]", ensure_string(seller_address, :city)) 
    @doc.replace("[[S_CITY]]", ensure_string(seller_address, :city)) 
    
    @doc.replace("[[S_STATE]]", ensure_string(seller_address, :state)) 
    @doc.replace("[[S_ZIP]]", ensure_string(seller_address, :zip)) 
    @doc.replace("[[S_STATE]]", ensure_string(seller_address, :state)) 
    @doc.replace("[[S_ZIP]]", ensure_string(seller_address, :zip)) 
    @doc.replace("[[SELLER_CONTRACT]]", @order.contract.seller_contract)
    @doc.replace("[[LOAD]]", @order.row_on_contract)
    @doc.replace("[[TREATMENT]]", @order.fumigation.try(:treatment).to_s)
    @doc.replace("[[TREAT_DATE]]", @order.fumigation.try(:date_of_treatment).to_s)
    @doc.replace("[[DURATION]]", @order.fumigation.try(:duration_of_exposure).to_s)
    @doc.replace("[[CONCENTRATION]]", @order.fumigation.try(:concentration).to_s)
    @doc.replace("[[TEMPERATURE]]", @order.fumigation.try(:temperature).to_s)
    @doc.replace("[[PERMIT]]", @order.fumigation.try(:permit_number).to_s)
    @doc.replace("[[COMMODITY]]", @order.fumigation.try(:commodity).to_s)
    @doc.replace("[[HS_CODE]]", @order.fumigation.try(:hs_code).to_s)

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