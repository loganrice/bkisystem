
class OrderPdf
  include Prawn::View

  def initialize(order, view)
    @view = view
    @order = order
    create_contract_report
  end

  def create_contract_report
    define_grid(columns: 5, rows: 12, gutter: 10)
    header
    move_down 20
    contract_number
    # seller_buyer_name_address

    grid.show_all

  end

  def header
    line [0, 650], [650, 650]
    stroke
    stroke_axis
    bounding_box([cursor, cursor], width: 200) do 
      text "alskdfjasdf adslfjasdfkjasfd asldfijasdflkjasdf asldfjasldkfj asdflkj"
    end
    grid([0,0],[0,4]).bounding_box do
      text "Sales Contract", size: 30, style: :bold, align: :center, valign: :bottom
    end

    grid(0,0).bounding_box do 
      image "#{Rails.root}/app/assets/images/bki_logo.png", :valign => :bottom
    end

  end

  def contract_number
    text "<b>Date:</b> #{@order.contract.date}", inline_format: true
    text "<b>Contract No:</b> #{@order.contract.id}", inline_format: true
    text "<b>Customer Contract No:</b> #{@order.contract.buyer_contract}", inline_format: true
  end

  def seller_buyer_name_address
    text "SELLER"
    grid(1,3).bounding_box do
      text "BUYER"
    end
    grid(6,3).bounding_box do
      text "SOMETHING"
    end
    grid.show_all
  end

  def line_item_rows
    items = [["Product", "Qty", "Unit Price", "Full Price"]] +
    @order.order_line_items.map do |item|
      [item.name, item.weight_total, item.price_dollars, item.invoice_total]
    end
    items.to_s
  end
end