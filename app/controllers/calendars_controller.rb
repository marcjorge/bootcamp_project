class CalendarsController < ApplicationController
	before_filter :authenticate_user

	def index
		@holidays = Holiday.all
		@user_records = @current_user.calendars
		@records = Calendar.all
    @date = params[:month] ? Date.parse(params[:month]) : Date.today
	end

	def time_in
		@time_in = Time.now
		@time_out = Time.now
		@date = Time.now.strftime("%Y-%m-%d")
    @time_in = @time_in.strftime("%I:%M:%S %p")
    @time_out = @time_out.strftime("%I:%M:%S %p") 
    user = session[:user_id]
    if session[:time_id].present?	
			Calendar.find(session[:time_id]).update(time_out: @time_out)
			redirect_to calendars_path	  
	  else
			calendar = Calendar.create(user_id: user, time_in: @time_in, date: @date)
			session[:time_id] = calendar.id
			redirect_to calendars_path
	  end
	end

end
