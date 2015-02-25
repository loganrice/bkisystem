class DeliveryLocationsController < ApplicationController
  before_filter :require_user

  def index
    @locations = DeliveryLocation.all
  end

  def new
    @location = DeliveryLocation.new
  end

  def edit
    @location = DeliveryLocation.find(params[:id])
  end

  def create
    @location = DeliveryLocation.new(location_params)
    if @location.save
      flash[:success] = "Updated"
      redirect_to delivery_locations_path
    else
      flash[:error] = @location.errors.full_messages
      render :new
    end
  end

  def update
    @location = DeliveryLocation.find(params[:id])
    if @location.update(location_params)
      flash[:success] = "Updated"
      redirect_to edit_delivery_location_path(@location)
    else
      flash[:error] = @location.errors.full_messages
      render :edit
    end
  end

  private

  def location_params
    params.require(:delivery_location).permit(:name, :description)
  end
end