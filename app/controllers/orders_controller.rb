class OrdersController < ApplicationController
  before_filter :require_user
  respond_to :js

  def index
    @orders = Order.all
  end

  def edit
    @order = Order.find(params[:id])
    if @order.commissions.count == 0
      @order.commissions.create()
    end
    # @quote_line_items = quote_items(@order)
  end

  def update
    binding.pry
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success] = "Updated"
    else

    end
    redirect_to edit_order_path(@order)
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
      :payment_terms,
      :remarks,
      :ship_pick_up,
      :ship_delivery,
      :contract_id, 
      order_line_items_attributes: [:item_id, :price_dollars, :weight_id, :pack_weight_pounds, :item_size_indicator_id, :pack_weight_kilograms, :pack_count, :pack_type_id, :id, :_destroy],
      commissions_attributes: [ :broker_id, :dollars_per_pound, :percent, :dollars, :id, :_destroy]
    )
  end
end