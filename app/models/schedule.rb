class Schedule < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true
  validate :schedule_on_cannot_be_in_the_past
  
  private 
  
    def schedule_on_cannot_be_in_the_past
      errors.add(:schedule_on, "can't be in the past") if !schedule_on.blank? and schedule_on < Time.now
    end
end
