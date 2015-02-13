class GradesController < ApplicationController
  before_filter :require_user
  respond_to :js

  def index
    @grades = Grade.all
  end

  def new
    @grade = Grade.new
  end

  def create
    @grade = Grade.new(grade_params)
    if @grade.save
      flash[:success] = "Updated"
      redirect_to grades_path
    else
      flash[:error] = "Sorry, something went wrong. The grade was not updated."
      render :new
    end
  end

  def edit
    @grade = Grade.find(params[:id])
  end

  def update
    @grade = Grade.find(params[:id])
    if @grade.update(grade_params)
      flash[:success] = "Updated"
      redirect_to edit_grade_path(@grade)
    else
      flash[:error] = "Sorry, something went wrong. The grade was not updated."
      render :edit
    end
  end

  private

  def grade_params
    params.require(:grade).permit(:name)
  end
end