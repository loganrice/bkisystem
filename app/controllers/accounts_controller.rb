class AccountsController < ApplicationController
  respond_to :js
  
  def index
    @accounts = Account.all
  end

  def new
    @account = Account.new
  end

  def edit 
    @account = Account.find(params[:id])
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      flash[:success] = "Updated"
      redirect_to accounts_path
    else
      flash[:error] = "Sorry, something went wrong. The commodity was not created."
      render :new
    end
  end

  def update
    @account = Account.find(params[:id])
    if @account.update(account_params)
      flash[:success] = "Updated"
      redirect_to accounts_path
    else
      flash[:error] = "Sorry, something went wrong. The commodity was not created."
      render :edit
    end
  end

  private

  def account_params
    params.require(:account).permit(
      :name, :phone1, :phone2, :fax, :first_name, :last_name,
      :email, :address_1_line_1, :address_1_line_2, :address_1_line_3,
      :address_1_city, :address_1_state, :address_1_zip, 
      :address_1_country
      )
  end
end