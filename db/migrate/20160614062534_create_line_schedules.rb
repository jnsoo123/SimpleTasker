class CreateLineSchedules < ActiveRecord::Migration
  def change
    create_table :line_schedules do |t|
      t.references :user, index: true
      t.references :schedule, index: true

      t.timestamps
    end
  end
end
