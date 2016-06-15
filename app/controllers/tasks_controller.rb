class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :destroy]
  before_action :set_update_task, only: :update
  before_action :set_user_task, only: [:create, :update, :destroy, :destroy_finished_task]
  
  respond_to :js
  
  rescue_from ActiveRecord::RecordInvalid, with: :invalid_task

  def index
    @tasks = Task.all
    respond_with(@tasks)
  end

  def show
  end

  def new
    @task = Task.new
    respond_with(@task)
  end

  def edit
  end

  def create
    @task = Task.new(task_params)
    @task.description += "\n\nCreated by: #{current_user.name}"
    
    if @task.save
      
      @included_users = Array.new
      @line_task = LineTask.new
      @line_task.user = current_user
      @line_task.task = Task.last
      @line_task.save
      
      @task.description.split(" ").each { |string_with_at| @included_users << string_with_at.tr('@','') if string_with_at.include?("@") }

      unless @included_users.empty?
        user_list = User.where.not(id: current_user.id)
        @included_users.each do |u|
          user = user_list.find_by(username: u)
          if user
            @include_user_to_task = LineTask.new
            @include_user_to_task.user = user
            @include_user_to_task.task = Task.last
            @include_user_to_task.save
          end
        end
      end
      respond_with @task
    else
      respond_with @task
    end
  end

  def update
    @task.update(task_params)
    respond_with(@task, location: home_path)
  end

  def destroy
    @task.destroy
    flash[:notice] = "Task deleted!"
    respond_with(@task)
  end
  
  def destroy_finished_task
    @user_finished_on_time.destroy_all
    respond_with(@user_finished_on_time)
  end
  
  def search
    @search = params[:search]
    @search_result = current_user.tasks.where('title like ?', "%#{@search}%")
    respond_with(@search_result)
  end

  private
  
    def set_user_task
      @user_tasks_due_this_week = current_user.tasks_due_this_week
      @user_tasks_due_not_this_week = current_user.tasks_not_due_this_week
      @user_finished_on_time = current_user.tasks_finished_on_time
    end
  
    def set_task
      @task = Task.find(params[:id])
      @task.deadline_on = @task.deadline_on.strftime('%d/%m/%Y %I:%M %p')
    end
  
    def set_update_task
      @task = Task.find(params[:id])
    end
  

    def task_params
      params.require(:task).permit(:title, :description, :deadline_on, :status, :finished_on)
    end
  
    def invalid_task
      flash[:error] = 'Title, description, and deadline can\'t be blank! Date cannot be in the past!'
      redirect_to home_path
    end
end
