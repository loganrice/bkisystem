class ItemsController < ApplicationController
  before_filter :require_user
  respond_to :js
  
  def index
    @items = Item.all
  end

  def new
    @item = Item.new
  end

  def show
    @item = Item.find(params[:id])
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      flash[:success] = "Item Created"
      redirect_to items_path
    else
      flash.now[:error] = "Sorry, something went wrong. The item was not created."
      render :new
    end
  end

  def edit
    @item = Item.find(params[:id])
  end

  def update
    
    @item = Item.find(params[:id])
    if @item.update(item_params)
      flash[:success] = "Item Updated"
      redirect_to edit_item_path(@item)
    else
      flash.now[:error] = "Sorry, something went wrong. The item was not updated."
      render :edit
    end
  end

  private
    def item_params
      params.require(:item).permit(:name, :commodity_id, :size_id, :variety_id) if params[:item]
    end
end