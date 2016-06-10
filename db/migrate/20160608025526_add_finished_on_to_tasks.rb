class AddFinishedOnToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :finished_on, :date
  end
end
