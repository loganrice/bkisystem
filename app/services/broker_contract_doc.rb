class BrokerContractDoc < ContractDoc 
  FILE_TEMPLATE_PATH = "#{Rails.root}/app/reports/broker_contract.docx"

  def initialize(contract)
    super
  end

  def create_contract
    @doc = DocxReplace::Doc.new(FILE_TEMPLATE_PATH, "#{Rails.root}/tmp")
    @doc.replace( "[[CONTRACT_NO]]", @contract.seller_contract.to_s)
    @doc.replace( "[[CUSTOMER_CONTRACT_NO]]", @contract.buyer_contract.to_s)
    @doc.replace( "[[SELLER_NAME]]", @contract.seller.try(:name).to_s)
    @doc.replace( "[[SELLER_LINE1]]", ensure_string(seller_address, :line1))
    @doc.replace( "[[SELLER_CITY]]", ensure_string(seller_address, :city))
    @doc.replace( "[[SELLER_STATE]]", ensure_string(seller_address, :state))
    @doc.replace( "[[SELLER_ZIP]]", ensure_string(seller_address, :zip))
    @doc.replace( "[[BUYER_NAME]]", @contract.buyer.try(:name).to_s)
    @doc.replace( "[[BUYER_LINE1]]", ensure_string(buyer_address, :line1))
    @doc.replace( "[[BUYER_CITY]]", ensure_string(buyer_address, :city))
    @doc.replace( "[[BUYER_STATE]]", ensure_string(buyer_address, :state))
    @doc.replace( "[[BUYER_ZIP]]", ensure_string(buyer_address, :zip))
    @doc.replace( "[[COMMODITY]]", commodity_season)
    @doc.replace( "[[DOCUMENTS]]", documents)
    @doc.replace( "[[QUANTITY]]", quantity)
    @doc.replace( "[[WEIGHT]]", weight)
    @doc.replace( "[[QUALITY]]", quality)
    @doc.replace( "[[PACKING]]", packaging_message)
    @doc.replace( "[[SHIPMENT]]", @contract.ship_date_note.to_s)
    @doc.replace( "[[PRICE]]", price)
    @doc.replace( "[[PAYMENT]]", @contract.payment_terms.to_s)
    @doc.replace( "[[REMARKS]]", @contract.remarks.to_s)
    @doc.replace( "[[SIGNATURE]]", @contract.seller.try(:name).to_s)
    @doc.replace( "[[DATE]]", @contract.contract_date.try(:strftime, '%m/%d%Y'))


    temp_file
  end

end
