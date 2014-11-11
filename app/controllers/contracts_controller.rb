class ContractsController < ApplicationController

  def home
    respond_to do |format|
      format.html
      format.js
    end
  end
  
  def index
    respond_to do |format|
      format.js
    end
  end

  def new
    respond_to do |format|
      format.js
    end
  end
end