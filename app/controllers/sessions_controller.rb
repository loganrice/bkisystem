class SessionsController < ApplicationController
  respond_to :js

  def new
    redirect_to home_path if current_user
  end
end