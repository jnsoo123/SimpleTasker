class CreateLineTasks < ActiveRecord::Migration
  def change
    create_table :line_tasks do |t|
      t.references :task, index: true
      t.references :user, index: true

      t.timestamps
    end
  end
end
