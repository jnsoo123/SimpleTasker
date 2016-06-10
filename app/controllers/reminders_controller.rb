class RemindersController < ApplicationController
  before_action :set_reminder, only: [:show, :edit, :update, :destroy]

  respond_to :js

  def index
    @reminders = Reminder.all
    respond_with(@reminders)
  end

  def show
    respond_with(@reminder)
  end

  def new
    @reminder = Reminder.new
    respond_with(@reminder)
  end

  def edit
  end

  def create
    @reminder = Reminder.new(reminder_params)
    @reminder.user = current_user
    @user_reminders = current_user.reminders
    @reminder.save
    respond_with(@reminder)
  end

  def update
    @reminder.update(reminder_params)
    @user_reminders = current_user.reminders
    respond_with(@reminder)
  end

  def destroy
    @user_reminders = current_user.reminders
    @reminder.destroy
    respond_with(@reminder)
  end
  
  def search
    @search = params[:search]
    @search_result = current_user.reminders.where('title like ?', "%#{@search}%")
    respond_with(@search_result)
  end

  private
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    def reminder_params
      params.require(:reminder).permit(:title, :done)
    end
end
