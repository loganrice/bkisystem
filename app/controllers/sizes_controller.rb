class SizesController < ApplicationController
  respond_to :js

  def index
    @sizes = Size.all 
  end

  def new
    @size = Size.new
  end

  def edit
    @size = Size.find(params[:id])
  end

  def create
    @size = Size.new(size_params)
    if @size.save
      flash[:success] = "Updated"
      redirect_to sizes_path
    else
      flash[:error] = "Sorry, something went wrong. The size was not updated."
      render :new
    end
  end

  def update
    @size = Size.find(params[:id])
    if @size.update(size_params)
      flash[:success] = "Updated"
      redirect_to edit_size_path(@size)
    else
      flash[:error] = "Sorry, something went wrong. The size was not updated."
      render :edit
    end
  end

  private

  def size_params
    params.require(:size).permit(:name)
  end
end