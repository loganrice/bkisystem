class CommoditiesController < ApplicationController

  def index
    @commodities = Commodity.all
  end

  def new
    @commodity = Commodity.new
  end

  def create
    @commodity = Commodity.new(commodity_params)
    if @commodity.save
      flash[:success] = "Updated"
      redirect_to commodities_path
    else
      flash.now[:error] = "Sorry, something went wrong. The commodity was not updated."
      render :new
    end
  end

  private

  def commodity_params 
    params.require(:commodity).permit(:description) if params[:commodity]
  end
end