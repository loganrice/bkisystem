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

  def update
    @certificate_of_origin = CertificateOfOrigin.find(params[:id])
    if @certificate_of_origin.update(certificate_of_origins_params)
      flash[:success] = "Updated"
      redirect_to edit_certificate_of_origin_path(@certificate_of_origin)
    else
      render :edit
    end
  end

  def show
    @order = CertificateOfOrigin.find(params[:id]).order 
    respond_to do |format|
      format.docx do
        report = CertificateOfOriginDoc.new(@order)
        # Respond to the request by sending the temp file
        send_file report.create_report, filename: "certificate_of_origin.docx", disposition: 'inline'
      end
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
      :order_id,
      :routing_instructions,
      :port_of_loading
      )
  end
end
