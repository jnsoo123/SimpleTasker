class ChangeTypeOfDeadlineOnInTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :deadline_on, :datetime
  end
end
