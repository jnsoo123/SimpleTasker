class ChangeTitleFromReminder < ActiveRecord::Migration
  def change
    change_column :reminders, :title, :text
  end
end
