class ContractsController < ApplicationController
  respond_to :js
  
  def index
    @contracts = Contract.all
  end

  def new
    @contract = Contract.new
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
    params.require(:contract).permit(:buyer_contract, :buyer_po, :seller_contract, :date)
  end
end