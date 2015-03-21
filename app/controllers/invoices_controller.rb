class InvoicesController < ApplicationController
  before_filter :require_user
  respond_to :js
  respond_to :docx

  def index
    @invoices = Invoice.all 
  end

  def new
    @order = Order.find(params[:order_id])

    @invoice = Invoice.new(order_id: @order.id)
    @invoice.invoice_line_items.new()
  end

  def create
    @invoice = Invoice.new(invoice_params)
    @order = @invoice.order

    if @invoice.save
      flash[:success] = "Updated" 
      # redirect_to controller: 'invoices', action: 'edit', order_id: @order.id, invoice_id: @invoice.id 
      redirect_to edit_invoice_path(@invoice)
    else
      flash[:error] = @invoice.errors.full_messages
      render :new
    end  
  end

  def edit
    @invoice = Invoice.find(params[:id])
    @order = @invoice.order
  end

  def update
    @invoice = Invoice.find(params[:id])
    @order = @invoice.order
    if @invoice.update(invoice_params)
      flash[:sucess] = "Updated"
      redirect_to edit_invoice_path(@invoice)
    else
      flash[:error] = @invoice.errors.full_messages
      render :edit  
    end
  end

  def invoice_report
    @invoice = Invoice.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = InvoicePdf.new(@invoice, view_context)
        send_data pdf.render, filename: "invoice_#{invoice.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def print
    word = /Lorem \r
        insert break here \n 
        ipsum dolor sit amet,\r\n consectetur adipisicing elit. Quas nulla nostrum aliquid laboriosam quo. Saepe, consequuntur ut rerum hic! Minus accusamus ut in, dolorem unde sequi autem eos? Maiores, odio.
        Lorem ipsum dolor sit amet\v, consectetur adipisicing elit. Quas nulla nostrum aliquid laboriosam quo. Saepe, consequuntur ut rerum hic! Minus accusamus ut in, dolorem unde sequi autem eos? Maiores, odio.
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas nulla nostrum aliquid laboriosam quo. Saepe, consequuntur ut rerum hic! Minus accusamus ut in, dolorem unde sequi autem eos? Maiores, odio.
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas nulla nostrum aliquid laboriosam quo. Saepe, consequuntur ut rerum hic! Minus accusamus ut in, dolorem unde sequi autem eos? Maiores, odio.
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas nulla nostrum aliquid laboriosam quo. Saepe, consequuntur ut rerum hic! Minus accusamus ut in, dolorem unde sequi autem eos? Maiores, odio.
        Lorem ipsum dolor sit amet, consectetur adipisicing elit. Quas nulla nostrum aliquid laboriosam quo. Saepe, consequuntur ut rerum hic! Minus accusamus ut in, dolorem unde sequi autem eos? Maiores, odio./
    report = ODFReport::Report.new(Rails.root.join('app', 'reports', 'test2.odt')) do |r|
      r.add_field(:test_id, word)
    end

    send_data report.generate,
      type: 'application/vnd.oasis.opendocument.text',
      disposition: 'attachment',
      filename: 'work.odt'
  end


  private

  def invoice_params
    params.require(:invoice).permit(
      :order_id, 
      :bank_id, 
      :address_id, 
      :payee_id, 
      :payer_id,
      :invoice_number,
      :show_bank_wire_info,
      :hide_commission,
      invoice_line_items_attributes: [:id, :amount_cents, :amount_dollars, :_destroy])
  end
end