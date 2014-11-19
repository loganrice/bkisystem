class ItemsController < ApplicationController
  
  def index
    @items = Item.all
    respond_to do |format|
      format.js
    end
  end

  def show
    @item = Item.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def edit
    @item = Item.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

  def update
    # binding.pry
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item Updated"
      redirect_to edit_item_path(@item)
    else
      flash[:error] = "Sorry, something went wrong. The item was not updated."
      render :edit
    end
  end

  private
    def item_params
      params.require(:item).permit(:description)
    end
end