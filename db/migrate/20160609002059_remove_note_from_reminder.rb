class RemoveNoteFromReminder < ActiveRecord::Migration
  def change
    remove_column :reminders, :note, :text
  end
end
