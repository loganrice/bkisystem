class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  def require_user
    redirect_to sign_in_path unless current_user
  end
  
  def current_user
    User.find_by_id(session[:user_id]) if session[:user_id]
  end

  helper_method :current_user
  
end
