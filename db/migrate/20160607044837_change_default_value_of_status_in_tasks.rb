class ChangeDefaultValueOfStatusInTasks < ActiveRecord::Migration
  def change
    change_column :tasks, :status, :string, default: 'ongoing'
  end
end
