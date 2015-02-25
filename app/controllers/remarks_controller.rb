class RemarksController < ApplicationController
  before_filter :require_user

  def index
    @remarks = Remark.all
  end

  def new
    @remark = Remark.new
  end

  def edit
    @remark = Remark.find(params[:id])
  end

  def create
    @remark = Remark.new(remark_params)
    if @remark.save
      flash[:success] = "Updated"
      redirect_to remarks_path
    else
      flash[:error] = @remark.errors.full_messages
      render :new
    end
  end

  def update
    @remark = Remark.find(params[:id])
    if @remark.update(remark_params)
      flash[:success] = "Updated"
      redirect_to edit_remark_path(@remark)
    else
      flash[:error] = @remark.errors.full_messages
      render :edit
    end
  end

  private

  def remark_params
    params.require(:remark).permit(:name, :description) 
  end
end