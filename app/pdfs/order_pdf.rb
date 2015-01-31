
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

    address(@contract.seller.addresses.first, 0, cursor) unless @contract.seller.addresses.blank?
    address(@contract.buyer.addresses.first, 300, cursor) unless @contract.buyer.addresses.blank?
    move_cursor_to 500
    line_item_rows

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

  def address(address, x_position, y_position)
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

  end


  def line_item_rows
    # items = [["Product", "Qty", "Unit Price", "Full Price"]] +
    # @order.order_line_items.map do |line_item|
    #   [line_item.item.name, line_item.weight_total, line_item.price_dollars, line_item.invoice_total]
    # end
    # text items.to_s
    text "Commodity: California Shelled Almonds - 2014"

    containers = "" 
    @contract.order_container_sizes.each do |key, value|
      containers += " #{value} X #{key}"
    end
    text "Quantity: #{containers}"

    text "Weight: About #{@view.number_with_precision(@contract.total_pounds, precision: 0, separator: ',', delimiter: ',')} in (#{@contract.orders.count}) shipments"
    move_down 15

    text "Quality: #{@contract_report.quality}"

    @contract_report.packaging_message.each do |summary|
      text summary
    end
  end
end