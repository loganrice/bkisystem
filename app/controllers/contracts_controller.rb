class ContractsController < ApplicationController
  before_filter :require_user
  respond_to :js
  
  def index
    @contracts = Contract.all
  end

  def new
    @contract = Contract.new
    @contract.orders.build
    @contract.quote = Quote.new
  end

  def edit
    @contract = Contract.find(params[:id])
  end

  def update
    @contract = Contract.find(params[:id])
    @contract.update(contract_params)
    flash[:success] = "Updated"
    redirect_to contracts_path
  end

  def create
    @contract = Contract.new(contract_params)
    @contract.save
    flash[:success] = "Updated"
    redirect_to contracts_path
  end

  private

  def contract_params
    params.require(:contract).permit(
      :buyer_contract, 
      :buyer_po, 
      :seller_contract, 
      :date, 
      :buyer_id, 
      :seller_id,
      orders_attributes: [:ship_date, :id, :_destroy,
        order_line_items_attributes: [:item_id, :price_cents, :quote_line_item_id, :weight_grams, :weight_pounds, :id, :_destroy]
      ],
      quote_attributes: [:id, :_destroy,
        quote_line_items_attributes: [:item_id, :price_dollars, :weight_id, :pack_weight_pounds, :item_size_indicator_id, :pack_weight_kilograms, :pack_count, :pack_type_id, :id, :_destroy]
      ]
    )
  end 
  
end