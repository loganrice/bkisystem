class OrdersController < ApplicationController
  before_filter :require_user
  respond_to :js

  def index
    @orders = Order.all
  end

  def new
    contract = Contract.find(params[:contract_id])
    if contract
      @order = contract.orders.create()
      redirect_to edit_order_path(@order)
    else
      redirect_to root_path
    end 
  end

  def edit
    @order = Order.find(params[:id])
    if @order.commissions.count == 0
      @order.commissions.create()
    end
    # @quote_line_items = quote_items(@order)
    render :edit
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success] = "Updated"
    else

    end
    redirect_to edit_order_path(@order)
  end

  def shipping_report
    order = Order.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = ShippingPdf.new(order, view_context)
        send_data pdf.render, filename: "shipping_#{order.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end
  
  private

  def quote_items(order)
    get_quote_line = QuoteLineItem.where(id: @order.quote_line_item)
    get_quote = get_quote_line.quote
    quote = Quote.find_by(id: get_quote.id)
    quote.line_items
  end

  def order_params
    params.require(:order).permit(
      :container_size,
      :ship_date,
      :last_received_date,
      :doc_cut_off,
      :estimated_arrival_date,
      :shipping_company,
      :voyage,
      :vessel,
      :ship_in_name_of,
      :booking_number,
      :commodity,
      :shipping_company_reference_number,
      :automated_export_number,
      :ship_pick_up,
      :ship_delivery,
      :port_of_discharge,
      :container_number,
      :consignee,
      :line1,
      :line2,
      :line3,
      :city,
      :state,
      :zip,
      :mail_to_id,
      :shipping_instructions,
      :discount_dollars_per_pound,
      :discount_percent,
      :discount_dollars,
      :contract_id,
      :buyer_po,
      :document_ids => [],
      order_line_items_attributes: [:item_id, :price_dollars, :weight_id, :pack_weight_pounds, :item_size_indicator_id, :pack_weight_kilograms, :pack_count, :pack_type_id, :id, :_destroy],
      commissions_attributes: [ :broker_id, :dollars_per_pound, :percent, :dollars, :id, :_destroy],
      invoices_attributes: [:id, :_destroy]
    )
  end
end