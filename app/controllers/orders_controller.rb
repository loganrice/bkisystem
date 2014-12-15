class OrdersController < ApplicationController
  before_filter :require_user

  def edit
    @order = Order.find(params[:id])
  end

  def update
    @order = Order.find(params[:id])
    if @order.update(order_params)
      flash[:success] = "Updated"
    else

    end
    redirect_to edit_order_path(@order)
  end

  private

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
      order_details_attributes: [:item_id, :price_cents, :size_indicator_id, :_destroy, :id]
    )
  end
end