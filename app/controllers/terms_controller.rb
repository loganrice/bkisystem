class TermsController < ApplicationController
  before_filter :require_user

  def index
    @terms = Term.all
  end

  def new
    @term = Term.new
  end

  def edit
    @term = Term.find(params[:id])
  end


  def create
    @term = Term.new(term_params)
    if @term.save
      flash[:success] = "Updated"
      redirect_to terms_path
    else
      flash[:error] = @term.errors.full_messages
      render :new
    end
  end

  def update
    @term = Term.find(params[:id])
    if @term.update(term_params)
      flash[:success] = "Updated"
      redirect_to edit_term_path(@term)
    else
      flash[:error] = @term.errors.full_messages
      render :edit
    end
  end

  private

  def term_params
    params.require(:term).permit(:name, :description)
  end
end