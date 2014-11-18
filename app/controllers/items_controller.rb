class ItemsController < ApplicationController
  
  def index
    @items = Item.all
    respond_to do |format|
      format.js
    end
  end

  def show
    @item = Item.find(params[:id])
  end

  def edit
    # @item = Item.find(params[:id])
    respond_to do |format|
      format.js
    end
  end

end