class VarietiesController < ApplicationController
  def index
    @varieties = Variety.all
  end

  def new
    @variety = Variety.new
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