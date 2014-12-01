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

  def edit
    @commodity = Commodity.find(params[:id])
  end

  def update
    @commodity = Commodity.find(params[:id])
    if @commodity.update(commodity_params)
      flash[:success] = "Updated"
      redirect_to edit_commodity_path(@commodity)
    else
      flash[:error] = "Sorry, something went wrong. The commodity was not created."
      render :edit
    end
  end

  private

  def commodity_params 
    params.require(:commodity).permit(:name) if params[:commodity]
  end
end