class UsersController < ApplicationController
  
  before_filter :authenticate_user
  before_filter :save_login_state, only: [:new, :create]
  
  def index
    @users = User.all
  end

  def show
    @user  = User.find(params[:id])
    @calendars = @user.calendars
  end

  def new
    @user = User.new 
  end

  def create
    @user = User.new(users_param)
    if @user.save
      flash[:notice] = "You signed up successfully"
      flash[:color]= "valid"
    else
      flash[:notice] = "Form is invalid"
      flash[:color]= "invalid"
    end
    render 'new'
  end

  def edit
    @current_user = User.find session[:user_id] 
    set_user
  end

  
  def update
    set_user
    if @user_edit
      @user_edit.update(users_param)
      @user_edit.save
      flash[:notice] = "User successfully updated"
      flash[:color]= "valid"
      redirect_to users_path
    else
      redirect_to edit_user_path
      flash[:notice] = "Failed to update"
      flash[:color]= "invalid"
    end
  end

  def edit_pass
    @current_user = User.find session[:user_id] 
  end

  def pass_reset
    @current_user = User.find session[:user_id]
    
    if @current_user.match_password(params[:user][:old_password])
      if params[:user][:password].length >= 6 && params[:user][:password] == params[:user][:password_confirmation]
        @current_user.update(password_reset)
        redirect_to logout_path
      else
        flash[:notice] = "Password is minimum of 6 characters"
        flash[:color] = "invalid"
        redirect_to edit_pass_path
      end
    else
      flash[:notice] = "Old password did not match"
      flash[:color] = "invalid"
      redirect_to edit_pass_path
    end

  end

  def destroy
    set_user
    if @current_user.admin
      @user_edit.delete
      flash[:notice] = "User has been deleted"
      flash[:color] = "valid"
      redirect_to users_path
    else
      flash[:notice] = "You don't have permission"
      flash[:color] = "invalid"
      redirect_to users_path
    end
  end

  private

    def set_user
      @user_edit = User.find(params[:id])
      @current_user = User.find session[:user_id]
    end

  	def users_param
   		params.require(:user).permit([:first_name, :last_name, :email ,:username ,:password, :password_confirmation, :admin])
  	end

    def password_reset
      params.require(:user).permit([:password, :password_confirmation])
    end

end
