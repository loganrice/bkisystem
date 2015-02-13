class InvoicesController < ApplicationController

  def edit
    @order = Order.find(params[:id])
    
  end

  def update
    binding.pry
    redirect_to root_path
  end
end