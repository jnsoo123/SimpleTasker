class ChangeDeadlineOnDataType < ActiveRecord::Migration
  def change
    change_column :tasks, :deadline_on, :date
  end
end
