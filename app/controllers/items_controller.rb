class ItemsController < ApplicationController
  
  def index
    @items = Item.all
    respond_to do |format|
      format.js
    end
  end
end