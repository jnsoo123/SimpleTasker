class CreateReminders < ActiveRecord::Migration
  def change
    create_table :reminders do |t|
      t.string :title
      t.text :note
      t.datetime :schedule_on

      t.timestamps
    end
  end
end
