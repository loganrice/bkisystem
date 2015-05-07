class CertificateOfOriginsController < ApplicationController
  before_filter :require_user
  
  def new
    @certificate_of_origin = CertificateOfOrigin.new(order_id: params[:order_id])
    render :new
  end

  def edit
    @certificate_of_origin = CertificateOfOrigin.find(params[:id])
    render :edit  
  end

  def create
    @certificate_of_origin = CertificateOfOrigin.new(certificate_of_origins_params)
    if @certificate_of_origin.save
      flash[:success] = "Updated"
      redirect_to edit_certificate_of_origin_path(@certificate_of_origin)
    else
      flash[:error] = @certificate_of_origin.errors.full_messages
      render :new
    end
  end

  private

  def certificate_of_origins_params
    params.require(:certificate_of_origin).permit(
      :treatment,
      :place_of_initial_receipt,
      :forwarding_agent,
      :initial_carriage_by,
      :vessel,
      :hs_code,
      :order_id
      )
  end
end
