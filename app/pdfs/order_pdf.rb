
class OrderPdf
  include Prawn::View

  def initialize(order, view)
    @view = view
    @order = order
    header
    line_items
  end

  def header
    bounding_box([0, 700], :width => 500, :height => 220) do
      text "Sales Contract", size: 30, style: :bold, align: :center
      # text "Order #{@order.id}", size: 30, style: :bold
    end
    bounding_box([0, 700], :width => 250, :height => 220) do
      image "#{Rails.root}/app/assets/images/bki_logo.png", :valign => :center
    end
    line [0, 650], [600, 650]
    stroke
    stroke_axis
  end

  def line_items
    text "Date: #{@order.contract.date}"
    text "Contract No:"
    text "Customer Contract No:"
  end

  def line_item_rows
    items = [["Product", "Qty", "Unit Price", "Full Price"]] +
    @order.order_line_items.map do |item|
      [item.name, item.weight_total, item.price_dollars, item.invoice_total]
    end
    items.to_s
  end
end