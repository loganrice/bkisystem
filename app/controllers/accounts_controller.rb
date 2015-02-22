class AccountsController < ApplicationController
  before_filter :require_user
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
    # binding.pry
    if @account.update_attributes(account_params)
      flash[:success] = "Updated"
      render :edit 
    else
      flash[:error] = "Sorry, something went wrong. The commodity was not created."
      render :edit
    end
  end

  def destroy
    account = Account.find(params[:id])
    if account.destroy
      flash[:success] = "Updated"
    end
    redirect_to accounts_path
  end

  private

  def account_params
    params.require(:account).permit(
      :name, :phone1, :phone2, :fax, :first_name, :last_name,
      :email, addresses_attributes: 
      [:line1, :line2, :line3, :city, :country, :zip, :id, :_destroy], 
      banks_attributes:
      [:name, :aba, :swift, :attention, :line1, :line2, :line3, :city, :state, :zip, :country, :id, :_destroy]
      )
  end
end