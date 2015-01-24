class OrderPdf
  include Prawn::View

  def initialize(order)
    @order = order
    order_number
    line_items
  end

  def order_number
    text "Order #{@order.id}", size: 30, style: :bold
    stroke_axis
  end

  def line_items
    move_down 20
    text "WTF"
  end

  def line_item_rows
    items = [["Product", "Qty", "Unit Price", "Full Price"]] +
    @order.order_line_items.map do |item|
      [item.name, item.weight_total, item.price_dollars, item.invoice_total]
    end
    items.to_s
  end
end