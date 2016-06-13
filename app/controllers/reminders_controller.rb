class RemindersController < ApplicationController
  before_action :set_reminder, only: [:show, :edit, :update, :destroy]
  before_action :set_user_reminder, only: [:create, :update, :destroy]

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
    @reminder.title = @reminder.title.to_s.gsub(/(\r)?\n/, '<br />')
    @reminder.user = current_user
    @reminder.save
    respond_with(@reminder)
  end

  def update
    @reminder.update(reminder_params)
    respond_with(@reminder)
  end

  def destroy
    @reminder.destroy
    respond_with(@reminder)
  end
  
  def search
    @search = params[:search]
    @search_result = current_user.reminders.where('title like ?', "%#{@search}%")
    respond_with(@search_result)
  end

  private
  
    def set_user_reminder
      @user_reminders = current_user.reminders
    end
  
    def set_reminder
      @reminder = Reminder.find(params[:id])
    end

    def reminder_params
      params.require(:reminder).permit(:title, :done, :id)
    end
end
