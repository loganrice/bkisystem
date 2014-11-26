class ContractsController < ApplicationController
  respond_to :js
  
  def index
    @contracts = Contract.all
  end

  def new
    @contract = Contract.new
  end
end