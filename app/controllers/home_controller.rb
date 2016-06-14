class HomeController < ApplicationController
  def index
    @task = Task.new
    @reminder = Reminder.new
    @schedule = Schedule.new
    
    @user_reminders = current_user.reminders
    
    @user_tasks = current_user.tasks.order('deadline_on')
    @user_tasks_due_this_week = current_user.tasks_due_this_week
    @user_tasks_due_not_this_week = current_user.tasks_not_due_this_week
    @user_finished_on_time = current_user.tasks_finished_on_time
    
    @user_schedule_for_today = current_user.schedule_for_today
    @user_week_schedule = current_user.week_schedule
    @user_incoming_schedule = current_user.incoming_schedule
    @user_past_schedule = current_user.past_schedule
    
    
  end
end
