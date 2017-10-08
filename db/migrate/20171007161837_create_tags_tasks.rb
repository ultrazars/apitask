class CreateTagsTasks < ActiveRecord::Migration[5.1]
  def change
    create_table :tags_tasks do |t|
      t.integer :tag_id, null: false
      t.integer :task_id, null: false

      t.timestamps
    end

    add_foreign_key :tags_tasks, :tags # looks like not supported in sqllite3
    add_foreign_key :tags_tasks, :tasks # looks like not supported in sqllite3
  end
end
