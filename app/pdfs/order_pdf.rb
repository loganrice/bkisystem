
class OrderPdf
  include Prawn::View

  def initialize(order, view)
    @view = view
    @order = order
    create_contract_report
  end

  def create_contract_report
    stroke_axis

    header
    move_down 20
    contract_number
    move_down 20
    seller_address
    # buyer_address
    # grid.show_all

  end

  def header
    image "#{Rails.root}/app/assets/images/bki_logo.png", at: [0, cursor]
    text "Sales Contract", size: 30, style: :bold, align: :center
    stroke_horizontal_rule
  end

  def contract_number
    text "<b>Date:</b> #{@order.contract.date}", inline_format: true
    text "<b>Contract No:</b> #{@order.contract.id}", inline_format: true
    text "<b>Customer Contract No:</b> #{@order.contract.buyer_contract}", inline_format: true
  end

  def seller_address
    text_box "<b><u>SELLER</u></b>", inline_format: true, at: [0, 600]
    text_box "<b><u>BUYER</u></b>", inline_format: true, at: [300, 600]

    move_down 15
    buyer_y_base = cursor 
    seller_y_base = cursor

    text_box @order.contract.seller.name, inline_format: true, at: [0, cursor]
    text_box @order.contract.buyer.name, inline_format: true, at: [300, buyer_y_base]

    buyer_y_base -= 15
    seller_y_base -= 15

    unless @order.contract.seller.addresses.first.line1.blank?
      text_box @order.contract.seller.addresses.first.line1, inline_format: true, at: [0, seller_y_base]
      seller_y_base -= 15
    end

    unless @order.contract.buyer.addresses.first.line1.blank?
      text_box @order.contract.buyer.addresses.first.line1, inline_format: true, at: [300, buyer_y_base]
      buyer_y_base -= 15
    end
    
    unless @order.contract.seller.addresses.first.line2.blank?
      text_box @order.contract.seller.addresses.first.line2, inline_format: true, at: [0, seller_y_base]
      seller_y_base -= 15 
    end

    unless @order.contract.buyer.addresses.first.line2.blank?
      text_box @order.contract.buyer.addresses.first.line2, inline_format: true, at: [300, buyer_y_base]
      buyer_y_base -= 15   
    end

    move_down 15

    unless @order.contract.seller.addresses.first.line3.blank?
      text_box @order.contract.seller.addresses.first.line3, inline_format: true, at: [0, seller_y_base]
      seller_y_base -= 15
    end

    unless @order.contract.buyer.addresses.first.line3.blank?
      text_box @order.contract.buyer.addresses.first.line3, inline_format: true, at: [300, buyer_y_base]
      buyer_y_base -= 15
    end

    text_box "#{@order.contract.seller.addresses.first.city} " +
             "#{@order.contract.seller.addresses.first.state} " +
             "#{@order.contract.seller.addresses.first.zip}", inline_format: true, at: [0, seller_y_base]
    text_box "#{@order.contract.buyer.addresses.first.city} " +
             "#{@order.contract.buyer.addresses.first.state} " +
             "#{@order.contract.buyer.addresses.first.zip}", inline_format: true, at: [300, buyer_y_base]
  end

  def buyer_address
    text_box "<b><u>BUYER</u></b>", inline_format: true, at: [300, 600]
    move_down 15

    text_box @order.contract.buyer.name, inline_format: true, at: [300, cursor]
    move_down 15

    text_box @order.contract.buyer.addresses.first.line1, inline_format: true, at: [300, cursor]

    unless @order.contract.buyer.addresses.first.line2.blank?
      move_down 15
      text_box @order.contract.buyer.addresses.first.line2, inline_format: true, at: [300, cursor]
    end

    unless @order.contract.buyer.addresses.first.line3.blank?
      move_down 15
      text_box @order.contract.buyer.addresses.first.line3, inline_format: true, at: [300, cursor]
    end
    move_down 15
    text_box "#{@order.contract.buyer.addresses.first.city} " +
             "#{@order.contract.buyer.addresses.first.state} " +
             "#{@order.contract.buyer.addresses.first.zip}", inline_format: true, at: [300, cursor]
  end

  def line_item_rows
    items = [["Product", "Qty", "Unit Price", "Full Price"]] +
    @order.order_line_items.map do |item|
      [item.name, item.weight_total, item.price_dollars, item.invoice_total]
    end
    items.to_s
  end
end