class AddEndedToTasks < ActiveRecord::Migration
  def change
    add_column :tasks, :ended, :datetime
  end
end
