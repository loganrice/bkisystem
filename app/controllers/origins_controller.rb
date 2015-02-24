class OriginsController < ApplicationController
  before_filter :require_user
  respond_to :js

  def index
    @origins = Origin.all
  end

  def new
    @origin = Origin.new
  end

  def edit
    @origin = Origin.find(params[:id])
  end

  def create
    @origin = Origin.new(origin_params)
    if @origin.save
      flash[:success] = "Updated"
      redirect_to origins_path
    else
      flash[:error] = @origin.errors.full_messages
      render :new
    end
  end

  def update
    @origin = Origin.find(params[:id])
    if @origin.update(origin_params)
      flash[:success] = "Updated"
      redirect_to edit_origin_path(@origin)
    else
      flash[:error] = @origin.errors.full_messages
      render :edit
    end
  end

  private

  def origin_params
    params.require(:origin).permit(:name)
  end
end