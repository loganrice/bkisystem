class InvoicePdf
  include Prawn::View

  def initialize(invoice, view)
    @view = view
    @invoice = invoice
    @contract = @invoice.order.contract 
    @line_space = 15
    @double_space = (@line_space * 2) 
    create_invoice_report
  
  end

  def create_invoice_report
    header
    move_down @line_space

    sub_header
    buyer_and_seller_address
    move_down 100

    order_details

    container_information
    move_down 50
    remit_funds_to
  end

  def header
    image "#{Rails.root}/app/assets/images/bki_logo.png", at: [0, cursor]
    text "Invoice", size: 30, style: :bold, align: :center
    stroke_horizontal_rule
  end

  def sub_header
    x_position = 0
    y_position = cursor  
    x_position_description =  150
    x_position_bill_to = 350

    text_box "<b><em>Bill To:</em></b>", inline_format: true, at: [x_position_bill_to, y_position]
    address(@invoice.payer, @invoice.payer.addresses.first, (x_position_bill_to + 50), y_position) unless @invoice.payer.addresses.blank?

    text_box "<b>Date:</b>", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.created_at.strftime("%m/%d/%Y")}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "<b>Invoice No:</b>", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.invoice_number}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "<b>Contract No:</b>", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.contract.id}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "<b>Load No:</b>", inline_format: true, at: [ x_position, y_position]
    text_box "#{@invoice.order.row_on_contract}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "<b>Customer PO:</b>", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.buyer_po}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "<b>Customer Contract No:</b>", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.contract.buyer_contract}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "<b>Ship Date:</b>", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.ship_date}", inline_format: true, at: [x_position_description, y_position]
    y_position -= (@line_space * 2)

    move_cursor_to y_position
  end

  def buyer_and_seller_address
    y_position = cursor
    line_spacing = @line_space 

    text_box "<b><u>BUYER:</u></b>", inline_format: true, at: [0, y_position]
    text_box "<b><u>SELLER:</u></b>", inline_format: true, at: [300, y_position]
    y_position -= @line_space

    address(@invoice.order.contract.buyer, @invoice.order.contract.buyer.addresses.first, 0, y_position) unless @invoice.order.contract.buyer.addresses.blank?
    address(@invoice.order.contract.acting_seller, @invoice.order.contract.acting_seller.addresses.first, 300, y_position) unless @invoice.order.contract.seller.addresses.blank?
    y_position -= @line_space

    move_cursor_to y_position 
  end

  def order_details
    y_position = cursor
    column_width = 80
    column1 = 0
    column2 = column1 + column_width 
    column3 = column2 + (0.7 * column_width)
    column4 = column3 + (0.5 * column_width) 
    column5 = column4 + (2.5 * column_width)  
    column6 = column5 + column_width 
     
    text_box "<b><em>Quantity</em></b>", inline_format: true, at: [column1, y_position]
    text_box "<b><em>Weight</em></b>", inline_format: true, at: [column2, y_position]
    text_box "<b><em>Unit</em></b>", inline_format: true, at: [column3, y_position]
    text_box "<b><em>Item Descriptioin</em></b>", inline_format: true, at: [column4, y_position]
    text_box "<b><em>Price</em></b>", inline_format: true, at: [column5, y_position]
    text_box "<b><em>Total</em></b>", inline_format: true, at: [column6, y_position]
    y_position -= @line_space

    move_cursor_to y_position
    stroke_horizontal_rule
    y_position -= 10

    @invoice.order.order_line_items.each do |line_item| 
      text_box "#{line_item.pack_count}", at: [column1, y_position]
      text_box "#{line_item.pack_weight_pounds}", at: [column2, y_position]
      text_box "#{line_item.pack_type.name}", at: [column3, y_position]
      text_box "#{line_item.item.name}", at: [column4, y_position]
      text_box "#{@view.number_to_currency(line_item.price_dollars)}", at: [column5, y_position]
      text_box "#{@view.to_dollars(line_item.invoice_total)}", at: [column6, y_position]
      y_position -= @line_space
    end 

    line [column6, y_position], [column6 + 80, y_position]
    stroke
    y_position -= (0.5 * @line_space)

    text_box "<em>Load Total:</em>", inline_format:true, at: [column5, y_position]
    text_box "<em>#{@view.to_dollars(@invoice.order.total_price_less_discount_plus_commission)}</em>", inline_format:true, at: [column6, y_position]
 
    y_position -= @line_space

    if @invoice.order.discount > 0
      text_box "<em>Discount</em>", inline_format:true, at: [column5, y_position]
      text_box "(#{@view.to_dollars(@invoice.order.discount)})", inline_format:true, at: [column6, y_position]
      y_position -= @line_space
    end

    unless @invoice.hide_commission
      text_box "<em>Commission</em>", inline_format:true, at: [column5, y_position]
      text_box "#{@view.to_dollars(@invoice.order.total_commission_cents)}", inline_format:true, at: [column6, y_position]
    end

    y_position -= @double_space


    text_box "<em>Total Due:</em>", inline_format:true, at: [column5, y_position], size: 15
    text_box "<em>#{@view.to_dollars(@invoice.invoice_line_items.first.amount_cents)}</em>", inline_format:true, at: [column6, y_position], size: 15

    line [15, y_position], [100, y_position]
    stroke
    y_position -= (0.5 * @line_space)
    text_box "<em>Total Lbs:</em>", inline_format: true, at: [column1, y_position]
    text_box "<em>#{@view.number_with_delimiter(@invoice.order.total_pounds)}</em>", inline_format: true, at: [column1 + 80, y_position]

    y_position -= @double_space

    move_cursor_to y_position 
  end

  def container_information
    x_position = 0
    y_position = cursor  
    x_position_description =  150
    x_position_bill_to = 350

    text_box "Container No:", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.container_number}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "Vessel:", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.vessel}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space


    text_box "Booking No:", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.booking_number}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "Destination:", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.port_of_discharge}", inline_format: true, at: [x_position_description, y_position]
    y_position -= @line_space

    text_box "Terms:", inline_format: true, at: [x_position, y_position]
    text_box "#{@invoice.order.contract.payment_terms}", inline_format: true, at: [x_position_description, y_position], height: 35, overflow: :shrink_to_fit
    y_position -= @line_space
    move_cursor_to y_position
  end

  def remit_funds_to
    x_position = 0
    y_position = cursor  
    x_position_description =  100
    x_position_bank = 200
    x_position_bank_description = 350

    stroke_horizontal_rule
    y_position -= @line_space
    text_box "<b><em>Remit Funds To:</em></b>", inline_format: true, at: [x_position, y_position]
    address(@invoice.payee, @invoice.payee.addresses.first, x_position_description, y_position) unless @invoice.payee.addresses.blank?

    if @invoice.show_bank_wire_info
      text_box "<b><em>Bank Wire Information:</em></b>", inline_format: true, at: [x_position_bank, y_position]
      bank_address(@invoice.bank, x_position_bank_description, y_position) unless @invoice.bank.blank?

      y_position -= @line_space * 5
      text_box "<b><em>ABA:</em></b>", inline_format: true, at: [x_position_bank, y_position]
      text_box "#{@invoice.bank.aba}", inline_format: true, at: [x_position_bank_description, y_position]
      y_position -= @line_space
       
      text_box "<b><em>Swift Code:</em></b>", inline_format: true, at: [x_position_bank, y_position]
      text_box "#{@invoice.bank.swift}", inline_format: true, at: [x_position_bank_description, y_position]
      y_position -= @line_space
      
      text_box "<b><em>Beneficiary Account:</em></b>", inline_format: true, at: [x_position_bank, y_position]
      text_box "#{@invoice.bank.account_number}", inline_format: true, at: [x_position_bank_description, y_position]
      y_position -= @line_space

      text_box "<b><em>Attention:</em></b>", inline_format: true, at: [x_position_bank, y_position]
      text_box "#{@invoice.bank.attention}", inline_format: true, at: [x_position_bank_description, y_position]
    end
    move_cursor_to y_position
  end

  def bank_address(bank, x_position, y_position)
    text_box bank.name, at: [x_position, y_position]
    y_position -= @line_space
    unless bank.line1.blank?
      text_box bank.line1, inline_format: true, at: [x_position, y_position]
      y_position -= @line_space
      
    end

    unless bank.line2.blank?
      text_box bank.line2, inline_format: true, at: [x_position, y_position]
      y_position -= @line_space 
    end

    unless bank.line3.blank?
      text_box bank.line3, inline_format: true, at: [x_position, y_position]
      y_position -= @line_space
    end
    text_box "#{bank.city} " +
             "#{bank.state} " +
             "#{bank.zip}", inline_format: true, at: [x_position, y_position]
 

    y_position -= @line_space
    move_cursor_to y_position 
  end

  def address(account, address, x_position, y_position)
    text_box account.name, at: [x_position, y_position]
    y_position -= @line_space
    unless address.line1.blank?
      text_box address.line1, inline_format: true, at: [x_position, y_position]
      y_position -= @line_space
      
    end

    unless address.line2.blank?
      text_box address.line2, inline_format: true, at: [x_position, y_position]
      y_position -= @line_space 
    end

    unless address.line3.blank?
      text_box address.line3, inline_format: true, at: [x_position, y_position]
      y_position -= @line_space
    end
    text_box "#{address.city} " +
             "#{address.state} " +
             "#{address.zip}", inline_format: true, at: [x_position, y_position]
    y_position -= @line_space
    text_box "#{account.phone1}", at: [x_position, y_position]

    y_position -= @line_space
    move_cursor_to y_position 
  end

end