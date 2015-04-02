class ShippingInstructionsController < ApplicationController
  before_filter :require_user
  
  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.docx do
        report = ShippingInstructionDoc.new(@order)
        # Respond to the request by sending the temp file
        send_file report.temp_file, filename: "shipping_report.docx", disposition: 'inline'
      end
    end
  end
end