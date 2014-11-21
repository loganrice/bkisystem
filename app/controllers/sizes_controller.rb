class SizesController < ApplicationController
  def index
    @sizes = Size.all 
  end
end