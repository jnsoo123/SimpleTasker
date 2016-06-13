class User < ActiveRecord::Base
  has_many :tasks
  has_many :reminders
  has_many :schedules
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  
  validates :name, presence: true
  
  def tasks_due_this_week
    tasks.where("deadline_on < ? and status = ?", 1.week.from_now, 'ongoing').order('deadline_on')
  end
  
  def tasks_not_due_this_week
    tasks.where('deadline_on > ? and status = ?', 1.week.from_now, 'ongoing').order('deadline_on')
  end
  
  def tasks_finished_on_time
    tasks.where('status = ?', 'done').order('deadline_on')
  end
  
#  def tasks_not_finished_on_time
#    tasks.where('deadline_on < ? and status = ?', Time.now, 'ongoing').order('deadline_on')
#  end
  
  def week_schedule
    schedules.where(schedule_on: Date.tomorrow..1.week.from_now).order('schedule_on')
  end
  
  def incoming_schedule
    schedules.where('schedule_on > ?', 1.week.from_now).order('schedule_on')
  end
  
  def past_schedule
    schedules.where('schedule_on < ?', Time.now).order('schedule_on')
  end
  
  def schedule_for_today
    schedules.where(schedule_on: Time.now..Date.tomorrow).order('schedule_on')
  end
end
