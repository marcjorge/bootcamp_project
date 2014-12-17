class AddStartedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :started, :datetime
  end
end
