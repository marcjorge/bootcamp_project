class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  protected

  def authenticate_user 
  	unless session[:user_id]
  		false
  	else
      @current_user = User.find session[:user_id] 
  		true
  	end
  end

  def save_login_state
    if session[:user_id].present?
      redirect_to calendars_path
    end
  end
  
end
