class FumigationsController < ApplicationController
  before_filter :require_user
  
  def new
    @fumigation = Fumigation.new(order_id: params[:order_id])
    render :new
  end

  def edit
    @fumigation = Fumigation.find(params[:id])
    render :edit  
  end

  def create
    @fumigation = Fumigation.new(fumigation_params)
    if @fumigation.save
      flash[:success] = "Updated"
      redirect_to edit_fumigation_path(@fumigation)
    else
      flash[:error] = @fumigation.errors.full_messages
      render :new
    end
  end

  def update
    @fumigation = Fumigation.find(params[:id])
    if @fumigation.update(fumigation_params)
      flash[:success] = "Updated"
      redirect_to edit_fumigation_path(@fumigation)
    else
      render :edit
    end
  end

  def show
    @order = Fumigation.find(params[:id]).order 
    respond_to do |format|
      format.docx do
        report = FumigationDoc.new(@order)
        # Respond to the request by sending the temp file
        send_file report.create_report, filename: "fumigation.docx", disposition: 'inline'
      end
    end
  end

  private

  def fumigation_params
    params.require(:fumigation).permit(
      :treatment,
      :duration_of_exposure,
      :temperature,
      :hs_code,
      :date_of_treatment,
      :concentration,
      :order_id,
      :notes,
      :permit_number
      )
  end
end
