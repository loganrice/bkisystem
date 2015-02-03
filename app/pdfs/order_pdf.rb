
class OrderPdf
  include Prawn::View

  def initialize(contract, view)
    @view = view
    @contract = contract
    @contract_report = ContractReport.new(@contract)

    create_contract_report
  end

  def create_contract_report
    # stroke_axis

    header
    move_down 20
    contract_number
    move_down 20
    # address
    text_box "<b><u>SELLER</u></b>", inline_format: true, at: [0, cursor]
    text_box "<b><u>BUYER</u></b>", inline_format: true, at: [300, cursor]
    move_down 15

    address(@contract.seller, @contract.seller.addresses.first, 0, cursor) unless @contract.seller.addresses.blank?
    address(@contract.buyer, @contract.buyer.addresses.first, 300, cursor) unless @contract.buyer.addresses.blank?
    move_cursor_to 500
    line_item_rows


    signature_line
  end

  def signature_line
    text_box @contract_report.signature, at: [0, 100]
    text_box "Seller Signature", inline_format: true, at: [0, 30]
    text_box "Buyer Signature", inline_format: true, at: [300, 30]
    
    text_box "Date:", at: [150, 30]
    text_box "Date:", at: [450, 30]

    horizontal_line 0, 200, :at => 40
    horizontal_line 300, 500, :at => 40
    stroke

  end

  def header
    image "#{Rails.root}/app/assets/images/bki_logo.png", at: [0, cursor]
    text "Sales Contract", size: 30, style: :bold, align: :center
    stroke_horizontal_rule
  end

  def contract_number
    text "<b>Date:</b> #{@contract.date}", inline_format: true
    text "<b>Contract No:</b> #{@contract.id}", inline_format: true
    text "<b>Customer Contract No:</b> #{@contract.buyer_contract}", inline_format: true
  end

  def address(account, address, x_position, y_position)
    text_box account.name, at: [x_position, y_position]
    y_position -= 15  
    unless address.line1.blank?
      text_box address.line1, inline_format: true, at: [x_position, y_position]
      y_position -= 15
    end

    unless address.line2.blank?
      text_box address.line2, inline_format: true, at: [x_position, y_position]
      y_position -= 15 
    end

    unless address.line3.blank?
      text_box address.line3, inline_format: true, at: [x_position, y_position]
      y_position -= 15
    end
    text_box "#{address.city} " +
             "#{address.state} " +
             "#{address.zip}", inline_format: true, at: [x_position, y_position]
    y_position -= 15
    text_box "#{account.phone1}", at: [x_position, y_position]
  
  end


  def line_item_rows
    # items = [["Product", "Qty", "Unit Price", "Full Price"]] +
    # @order.order_line_items.map do |line_item|
    #   [line_item.item.name, line_item.weight_total, line_item.price_dollars, line_item.invoice_total]
    # end
    # text items.to_s
    y_position = cursor
    x_description_position = 80
    line_space = 15

    text_box "<i><b>Commodity:</b></i>", inline_format: true, at: [0, y_position]
    text_box "California Shelled Almonds - 2014", inline_format: true, at: [x_description_position, y_position]



    y_position -= line_space
    containers = "" 
    @contract.order_container_sizes.each do |key, value|
      containers += " #{value} X #{key}"
    end
    text_box "<i><b>Quantity:",inline_format: true , at: [0, y_position]
    text_box containers, at: [x_description_position, y_position]
    y_position -= line_space

    text_box "<i><b>Weight:</b></i>", inline_format: true, at: [0, y_position] 
    text_box "About #{@view.number_with_precision(@contract.total_pounds, precision: 0, separator: ',', delimiter: ',')} lbs " +
              "in (#{@contract.orders.count}) shipments", at: [x_description_position, y_position]
    y_position -= line_space * 2

    text_box "<i><b>Quality:</b></i>", inline_format: true,  at: [0, y_position]
    @contract_report.quality.each do |quality_type|
      text_box quality_type.titleize, at: [x_description_position, y_position]
      y_position -= line_space
    end

    y_position -= line_space

    text_box "<i><b>Packing:</b></i>", inline_format: true, at: [0, y_position]

    @contract_report.packaging_message.each do |summary|
      text_box summary, at: [x_description_position, y_position]
      y_position -= line_space
    end
    
    y_position -= line_space

    text_box "<i><b>Shipment:</b></i>", inline_format: true, at: [0, y_position]

    @contract_report.ship_date_note.each do |date|
      text_box date, at: [x_description_position, y_position]
      y_position -= line_space
    end

    text_box "<i><b>Price:</b></i>", inline_format: true, at: [0, y_position]

    @contract_report.price.each do |price_line|
      text_box price_line, at: [x_description_position, y_position]
      y_position -= line_space
    end

    y_position -= line_space

    text_box "<i><b>Documents:</b></i>", inline_format: true, at: [0, y_position] 
    text_box @contract_report.documents.to_s, at: [x_description_position, y_position], height: 45, overflow: :shrink_to_fit
   
    y_position -= line_space * 3
    
    text_box "<i><b>Payment:</b></i>", inline_format: true, at: [0, y_position]
    text_box @contract.payment_terms, at: [x_description_position, y_position]
    
    y_position -= line_space * 4

    text_box "<i><b>Remarks:</b></i>", inline_format: true, at: [0, y_position]
    text_box @contract.remarks, at: [x_description_position, y_position]
  end
end