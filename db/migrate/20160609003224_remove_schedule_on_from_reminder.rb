class RemoveScheduleOnFromReminder < ActiveRecord::Migration
  def change
    remove_column :reminders, :schedule_on, :datetime
  end
end
