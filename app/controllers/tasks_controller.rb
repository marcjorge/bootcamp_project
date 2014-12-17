class TasksController < ApplicationController
	before_filter :authenticate_user

	def index
		@project = Project.find(params[:project_id])
		@tasks = Task.where(project_id: params[:project_id])

	end

  def new
  	@project = Project.find params[:project_id]
  	@task = Task.new(project: @project)
  end

  def create
     @task = Task.new(task_params, user_id: @current_user.id)
     @task.project = Project.find params[:project_id]
    if @task.save
      flash[:notice] = "Task Added successfully"
      flash[:color] = "valid"
    else
      flash[:notice] = "Failed to add"
      flash[:color] = "invalid"
    end
    redirect_to  project_tasks_path
  end


  def edit
  	set_task
    @task_edit = Task.find(params[:id])
  end

  def update
  	set_task
  	if @task_edit
  		@task_edit.update(task_params)
  		@task_edit.save
  		flash[:notice] = "Task successfully updated"
      flash[:color] = "valid"
      redirect_to project_tasks_path
     else
     	flash[:notice] = "Failed to update"
      flash[:color] = "invalid"
      edit_project_task_path
    end
  end


  def show
    set_task
    @project = Project.find(params[:project_id])
    @task = Task.find(params[:id])
    @task.started
    @task.ended
  end

  def destroy
    set_task
    @task_edit.delete
    redirect_to project_tasks_path
    flash[:notice] = "Task has been deleted"
    flash[:color] = "valid"
  end

  def timer
    @task_edit = Task.find(params[:id])
    @timer_in = Time.now
    @timer_end = Time.now
    @timer_in = @timer_in.strftime("%I:%M:%S %p")
    @timer_end = @timer_end.strftime("%I:%M:%S %p")
    if @task_edit.started.nil?
      @task_edit.update(started: @timer_in)
    else
      @task_edit.update(ended: @timer_end)
    end
  end


  private
	  def set_task
	    @task_edit = Task.find(params[:id])
	    @project_edit = Project.find params[:project_id]
	  end

    # def timer_params
    #   params.require(:task).permit([:started, :ended])

  	def task_params
  		params.require(:task).permit([:name, :description, :project_id, :user_id])
  	end

end
