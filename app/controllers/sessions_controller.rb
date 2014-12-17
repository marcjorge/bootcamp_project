class SessionsController < ApplicationController
  before_filter :authenticate_user, only: [:home, :users, :calendar, :projects]
  before_filter :save_login_state, only: [:login, :login_attempt]

  def home
  end
  
  def login
  end

  def login_attempt
		authorized_user = User.authenticate(params[:username_or_email],params[:login_password])
		if authorized_user
			session[:user_id] = authorized_user.id
			if authorized_user.calendars.nil?
				flash[:notice] = "Welcome, you logged in as #{authorized_user.username}"
				redirect_to calendars
			else
				time_sample = authorized_user.calendars.last
				if time_sample.present?
					session[:time_id] = time_sample.id if time_sample.date == Date.today.to_s
				end
				flash[:notice] = "Welcome, you logged in as #{authorized_user.username}"
				redirect_to calendars_path
			end
		else
			flash[:notice] = "Invalid Username or Password"
      flash[:color]= "invalid"
			render "login"	
		end
	end

  def logout
		session[:user_id] = nil
		session[:time_id] = nil
		redirect_to login_path
	end


end
