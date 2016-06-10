class AddStatusToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :status, :string
    add_column :tasks, :deadline_on, :datetime
  end
end
