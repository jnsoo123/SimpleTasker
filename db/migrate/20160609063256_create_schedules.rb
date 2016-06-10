class CreateSchedules < ActiveRecord::Migration
  def change
    create_table :schedules do |t|
      t.string :title
      t.datetime :schedule_on
      t.references :user, index: true

      t.timestamps
    end
  end
end
