class DocumentsController < ApplicationController
  before_filter :require_user
   
  def index
    @documents = Document.all
  end

  def new
    @document = Document.new
  end

  def edit
    @document = Document.find(params[:id])
  end

  def create
    @document = Document.new(document_params)
    if @document.save
      flash[:success] = "Updated"
      redirect_to documents_path
    else
      flash[:error] = "Sorry, something went wrong. The size was not updated."
      render :new
    end
  end

  def update
    @document = Document.find(params[:id])
    if @document.update(document_params)
      flash[:success] = "Updated"
      redirect_to edit_document_path(@document)
    else
      flash[:error] = "Sorry, something went wrong. The size was not updated."
      render :edit
    end
  end

  def document_params
    params.require(:document).permit(:name)
  end
end