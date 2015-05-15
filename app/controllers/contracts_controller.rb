class ContractsController < ApplicationController
  before_filter :require_user
  respond_to :js

  def home
    @pounds = TotalPoundsByMonthChart.new
    @top_varieties = TotalPoundsChart.new.chart_data
    respond_to do |format|
      format.html 
      format.js { render 'dashboard.js'}
    end
  end

  def index
    @contracts = Contract.all
  end

  def new
    @contract = Contract.new
    @terms = Term.all 
    @remarks = Remark.all
  end

  def edit
    @contract = Contract.find(params[:id])
    @terms = Term.all
    @remarks = Remark.all
  end

  def update
    @terms = Term.all 
    @remarks = Remark.all
    check_each_quote_line_weight
    @contract = Contract.find(params[:id])
    if @contract.update(contract_params)
      flash[:success] = "Updated"
      redirect_to edit_contract_path(@contract)
    else
      flash[:error] = @contract.errors.full_messages.join(" ")
      render :edit
    end
  end

  def create
    @contract = Contract.new(contract_params)
    @terms = Term.all 
    @remarks = Remark.all 
    if @contract.save
      flash[:success] = "Updated"
      redirect_to edit_contract_path(@contract)
    else
      flash[:error] = @contract.errors.full_messages.to_sentence
      render :new
    end
  end

  def contract_report
    contract = Contract.find(params[:id])
    respond_to do |format|
      format.pdf do
        pdf = OrderPdf.new(contract, view_context)
        send_data pdf.render, filename: "order_#{contract.id}.pdf",
                              type: "application/pdf",
                              disposition: "inline"
      end
    end
  end

  def contract_doc
    @contract = Contract.find(params[:id])
    respond_to do |format|
      format.docx do
        report = ContractDoc.new(@contract)
        # Respond to the request by sending the temp file
        send_file report.temp_file, filename: "contract_report.docx", disposition: 'inline'
      end
    end
  end

  def broker_contract_doc
    @contract = Contract.find(params[:id])
    respond_to do |format|
      format.docx do
        report = BrokerContractDoc.new(@contract)
        # Respond to the request by sending the temp file
        send_file report.temp_file, filename: "broker_contract_report.docx", disposition: 'inline'
      end
    end
  end

  private

  def contract_params
    params.require(:contract).permit(
      :buyer_contract, 
      :buyer_po, 
      :seller_contract, 
      :date, 
      :buyer_id, 
      :seller_id,
      :payment_terms,
      :remarks,
      :ship_date_note,
      :acting_seller_id,
      :contract_date,
      orders_attributes: [:ship_date, :id, :_destroy,
        order_line_items_attributes: [:item_id, :price_dollars, :weight_id, :pack_weight_pounds, :item_size_indicator_id, :pack_weight_kilograms, :pack_count, :pack_type_id, :id, :_destroy]
      ],
      quote_attributes: [:id, :_destroy,
        quote_line_items_attributes: [:item_id, :price_dollars, :weight_id, :pack_weight_pounds, :item_size_indicator_id, :pack_weight_kilograms, :pack_count, :pack_type_id, :id, :_destroy]
      ]
    )
  end

  def check_each_quote_line_weight
    unless quote_lines_nil?
      params[:contract][:quote_attributes][:quote_line_items_attributes].try(:each) do |key, attributes|
        next if weights_nil?(attributes)

        if is_kilograms? attributes[:weight_id]
          if attributes[:pack_weight_kilograms].nil?
            switch_lb_to_kg(key, attributes[:pack_weight_pounds])
          end
        else 
          if attributes[:pack_weight_pounds].nil?
            switch_kg_to_lb(key, attributes[:pack_weight_kilograms])
          end
        end
      end
    end
  end

  def quote_lines_nil?
    nil == params[:contract][:quote_attributes].try(:fetch, :quote_line_items_attributes, nil)
  end

  def weights_nil?(hash)
    hash[:pack_weight_kilograms].nil? && hash[:pack_weight_pounds].nil?
  end

  def switch_kg_to_lb(key, value)
    params[:contract][:quote_attributes][:quote_line_items_attributes][key][:pack_weight_pounds] = value
    params[:contract][:quote_attributes][:quote_line_items_attributes][key].delete :pack_weight_kilograms
  end

  def switch_lb_to_kg(key, value)
    params[:contract][:quote_attributes][:quote_line_items_attributes][key][:pack_weight_kilograms] = value
    params[:contract][:quote_attributes][:quote_line_items_attributes][key].delete :pack_weight_pounds
  end

  def is_kilograms?(weight_id)
    weight = Weight.find_by(id: weight_id)
    weight.weight_unit_of_measure == "kilograms"
  end
end