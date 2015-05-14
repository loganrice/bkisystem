class PackingListsController < ApplicationController
  before_filter :require_user
  
  def show
    @order = Order.find(params[:id])
    respond_to do |format|
      format.docx do
        report = PackingListDoc.new(@order)
        # Respond to the request by sending the temp file
        send_file report.create_report, filename: "packing_list.docx", disposition: 'inline'
      end
    end
  end
end