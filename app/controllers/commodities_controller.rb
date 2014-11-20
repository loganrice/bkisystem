class CommoditiesController < ApplicationController

  def index
    @commodities = Commodity.all
  end
end