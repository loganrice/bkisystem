class ShippingPdf
  include Prawn::View

  def initialize(order, view)
    @view = view
    @order = order

    create_shipping_report
  
  end

  def create_shipping_report
    header
    move_down 15

    address(@order.acting_seller, @order.acting_seller.addresses.first, 0, cursor) unless @order.contract.seller.addresses.blank?
    sub_header
    move_down 15

    shipper
    move_down 65
    container
    move_down 20

    shipping_company
    documents
    consignee
    special_instructions
    mail_docs_to
  end 

  def header
    image "#{Rails.root}/app/assets/images/bki_logo.png", at: [0, cursor]
    text "Shipping Instructions", size: 30, style: :bold, align: :center
    stroke_horizontal_rule
  end

  def sub_header
    text_box "<b>Date:</b> #{@order.created_at.strftime("%m/%d/%Y")}", inline_format: true, at: [300, cursor]
    move_down 15
    text_box "<b>Contract No:</b> #{@order.contract.seller_contract}", inline_format: true, at: [300, cursor]
    move_down 15
    text_box "<b>Load:</b> #{@order.row_on_contract}", inline_format: true, at: [300, cursor]
    move_down 15
    text_box "<b>Buyer Contract No:</b> #{@order.contract.buyer_contract}", inline_format: true, at: [300, cursor]
    move_down 15


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

  def shipper
    text_box "<b><em>Shipper:</em></b>", inline_format: true, at: [0, cursor]
    address(@order.contract.seller, @order.contract.seller.addresses.first, 110, cursor)
  end

  def container
    y_position = cursor
    x_description_position = 110
    line_space = 15

    text_box "<i><b>Container:</b></i>", inline_format: true, at: [0, y_position]
    text_box "1 X #{@order.container_size} of #{@order.contract.orders.count}", inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space

    text_box "<i><b>Commodity:</b></i>", inline_format: true, at: [0, y_position]
    text_box "Need commodity Method", inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space

    text_box "<i><b>Detail:</b></i>", inline_format: true, at: [0, y_position]
    @order.order_line_items.each do |line_item|
      pack_type = PackType.find(line_item.pack_type_id).name
      variety = "#{line_item.item.variety.name} type".titleize
      size = line_item.item.size.name
      grade = line_item.item.grade.name.titleize
      text_box "#{line_item.pack_count} X #{line_item.pack_weight_pounds} Lb #{pack_type} #{variety} - #{size} #{grade}", inline_format: true, at: [x_description_position, y_position]
      y_position -= line_space
      
    end 
    move_cursor_to y_position
  end

  def shipping_company
    y_position = cursor
    x_description_position = 110
    line_space = 15

    text_box "<i><b>Shipping Co:</b></i>", inline_format: true, at: [0, y_position]
    text_box @order.shipping_company, inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space

    text_box "<i><b>Vessel:</b></i>", inline_format: true, at: [0, y_position]
    text_box @order.vessel, inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space

    text_box "<i><b>Voyage:</b></i>", inline_format: true, at: [0, y_position]
    text_box @order.voyage, inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space

    text_box "<i><b>Booking No:</b></i>", inline_format: true, at: [0, y_position]
    text_box @order.booking_number, inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space

    text_box "<i><b>Last Receiving:</b></i>", inline_format: true, at: [0, y_position]
    text_box "#{@order.last_received_date.strftime("%m/%d/%Y")}", inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space

    text_box "<i><b>Pick Up:</b></i>", inline_format: true, at: [0, y_position]
    text_box "#{@order.ship_pick_up}", inline_format: true, at: [x_description_position, y_position]
    y_position -= 3 * line_space

    text_box "<i><b>Delivery:</b></i>", inline_format: true, at: [0, y_position]
    text_box "#{@order.ship_delivery}", inline_format: true, at: [x_description_position, y_position]
    y_position -= 3 * line_space

    text_box "<i><b>Port of Discharge:</b></i>", inline_format: true, at: [0, y_position]
    text_box "#{@order.port_of_discharge}", inline_format: true, at: [x_description_position, y_position]
    text_box "<i><b>Container #:</b></i>", inline_format: true, at: [x_description_position + 200, y_position]
    text_box "#{@order.container_number}", inline_format: true, at: [x_description_position + 275, y_position]
    y_position -= 1.5 * line_space
    move_cursor_to y_position

  end

  def documents

    y_position = cursor
    x_description_position = 110
    line_space = 15

    text_box "<i><b>Documents:</b></i>", inline_format: true, at: [0, y_position]
    text_box "In the name of #{@order.contract.seller.name} as shipper/exporter.", inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space
    documents = @order.documents.map { |document| document.name}.join(", ")
    text_box "#{documents}", inline_format: true, at: [x_description_position, y_position],height: 45, overflow: :shrink_to_fit
    y_position -= 3 * line_space
    move_cursor_to y_position
  end

  def consignee
    y_position = cursor
    x_description_position = 110
    line_space = 15

    text_box "<i><b>Consignee:</b></i>", inline_format: true, at: [0, y_position]
    text_box "#{@order.consignee}", inline_format: true, at: [x_description_position, y_position]
    y_position -= line_space 

    unless @order.line1.blank?
      text_box @order.line1, inline_format: true, at: [x_description_position, y_position]
      y_position -= line_space 
    end

    unless @order.line2.blank?
      text_box @order.line2, inline_format: true, at: [x_description_position, y_position]
      y_position -= line_space 
    end

    unless @order.line3.blank?
      text_box @order.line3, inline_format: true, at: [x_description_position, y_position]
      y_position -= line_space 
    end

    text_box "#{@order.city} #{@order.zip}", inline_format: true, at: [x_description_position, y_position]
    y_position -= 2 * line_space
    move_cursor_to y_position

  end

  def special_instructions
    y_position = cursor
    x_description_position = 110
    line_space = 15

    text_box "<i><b>Special Instr:</b></i>", inline_format: true, at: [0, y_position]
    text_box "#{@order.shipping_instructions}", inline_format: true, at: [x_description_position, y_position]
    y_position -= 3 * line_space
    move_cursor_to y_position
  end

  def mail_docs_to
    y_position = cursor
    x_description_position = 110
    line_space = 15

    text_box "<i><b>Mail Docs To:</b></i>", inline_format: true, at: [0, y_position]
    address(@order.mail_to, @order.mail_to.addresses.first, x_description_position, y_position)
    y_position -= line_space
    move_cursor_to y_position
  end
end