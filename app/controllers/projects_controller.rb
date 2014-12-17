class ProjectsController < ApplicationController
  before_filter :authenticate_user

	def new
    @current_user
    @project = Project.new
    @users = User.all
  end

	def index
		@projects = Project.all
    @project_group = ProjectGroup.all
  end

  def show
    @project = Project.find(params[:project_id])
  end

	def create
    @current_user
    @project = Project.new(projects_param)
    if @current_user.admin
      if params[:users_ids].present?   
        if @project.save
          params[:users_ids].each do |user|
          ProjectGroup.create(project_id: @project.id ,user_id: user)
          end 
          flash[:notice] = "Project Added successfully"
          flash[:color] = "valid"
          redirect_to projects_path
        else
          flash[:notice] = "Failed to add"
          flash[:color] = "invalid"
          redirect_to projects_path
        end
      else
        flash[:notice] = "Failed to add"
        flash[:color] = "invalid"
        redirect_to projects_path
      end
    else
      flash[:notice] = "Failed to add"
      flash[:color] = "invalid"
      redirect_to projects_path
    end
	end

  def edit
    set_project
  end

  def update
    set_project
    if @project_edit
      @project_edit.update(projects_param)
      @project_edit.save
      flash[:notice] = "Project successfully updated"
      flash[:color] = "valid"
      redirect_to projects_path
    else
      redirect_to edit_project_path
      flash[:notice] = "Failed to update"
      flash[:color] = "invalid"
    end
  end

  def destroy
    set_project
    if @current_user.admin
      if @project_edit.user_id == @current_user.id  
        @project_edit.delete
        redirect_to projects_path
        flash[:notice] = "Project has been deleted"
        flash[:color] = "valid"
      else
        flash[:notice] = "You have no permission to delete that project"
        flash[:color] = "invalid"
        redirect_to projects_path
      end
    else
      flash[:notice] = "You have no permission to delete that project"
      flash[:color] = "invalid"
    end
  end

	 private

    def set_project
      @project_edit = Project.find(params[:id])
      @current_user
    end

  	def projects_param
   		params.require(:project).permit([:name, :user_id, :description, :deadline])
  	end

end
