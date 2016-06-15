class SchedulesController < ApplicationController
  before_action :set_schedule, only: [:show, :edit, :destroy]
  before_action :set_schedule_update, only: :update
  before_action :set_user_schedule, only: [:create, :update, :destroy, :destroy_past_schedule]

  respond_to :js

  def index
    @schedules = Schedule.all
    respond_with(@schedules)
  end

  def show
    respond_with(@schedule)
  end

  def new
    @schedule = Schedule.new
    respond_with(@schedule)
  end

  def edit
  end

  def create
    @schedule = Schedule.new(schedule_params)
    
    if @schedule.save
      
      @included_users = Array.new
      @line_schedule = LineSchedule.new
      @line_schedule.user = current_user
      @line_schedule.schedule = Schedule.last
      @line_schedule.save
      
      params[:with].split(" ").each { |string_with_at| @included_users << string_with_at.tr('@','') if string_with_at.include?("@") }
      
      unless @included_users.empty?
        user_list = User.where.not(id: current_user.id)
        @included_users.each do |u|
          user = user_list.find_by(username: u)
          if user
            @include_user_to_schedule = LineSchedule.new
            @include_user_to_schedule.user = user
            @include_user_to_schedule.schedule = Schedule.last
            @include_user_to_schedule.save! 
          end
        end
      end
      respond_with(@schedule)
    end
  end

  def update
    @schedule.update(schedule_params)
    respond_with(@schedule)
  end

  def destroy
    @schedule.destroy
    respond_with(@schedule)
  end
  
  def destroy_past_schedule
    @user_past_schedule.destroy_all
    respond_with(@user_past_schedule)
  end
  
  def search
    @search = params[:search]
    @search_result = current_user.schedules.where('title like ?', "%#{@search}%")
    respond_with(@search_result)
  end

  private
  
    def set_user_schedule
      @user_schedule_for_today = current_user.schedule_for_today
      @user_week_schedule = current_user.week_schedule
      @user_incoming_schedule = current_user.incoming_schedule
      @user_past_schedule = current_user.past_schedule
      @user_schedules = current_user.schedules
    end
  
    def set_schedule
      @schedule = Schedule.find(params[:id])
      @schedule.schedule_on = @schedule.schedule_on.strftime('%d/%m/%Y %I:%M %p')
    end
  
    def set_schedule_update
      @schedule = Schedule.find(params[:id])
    end

    def schedule_params
      params.require(:schedule).permit(:title, :schedule_on, :user_id)
    end
end
