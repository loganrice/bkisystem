class VarietiesController < ApplicationController
  respond_to :js

  def index
    @varieties = Variety.all
  end

  def new
    @variety = Variety.new
  end

  def create
    @variety = Variety.new(variety_params)
    if @variety.save
      flash[:success] = "Updated"
      redirect_to varieties_path
    else
      flash[:error] = "Sorry, something went wrong. The variety was not updated."
      render :new
    end
  end

  def edit
    @variety = Variety.find(params[:id])
  end

  def update
    @variety = Variety.find(params[:id])
    if @variety.update(variety_params)
      flash[:success] = "Updated"
      redirect_to edit_variety_path(@variety)
    else
      flash[:error] = "Sorry, something went wrong. The variety was not updated."
      render :edit
    end
  end

  private

  def variety_params
    params.require(:variety).permit(:name)
  end
end