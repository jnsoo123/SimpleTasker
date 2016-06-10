class Task < ActiveRecord::Base
  belongs_to :user
  
  validates :title, presence: true
  validates :deadline_on, presence: true
  
  validate :deadline_on_cannot_be_in_the_past
  
  private 
  
    def deadline_on_cannot_be_in_the_past
      errors.add(:deadline_on, "can't be in the past") if !deadline_on.blank? and deadline_on < Date.today
    end
end
