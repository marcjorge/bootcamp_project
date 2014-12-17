class AddUserIdToProjectGroup < ActiveRecord::Migration
  def change
    add_column :project_groups, :user_id, :integer
  end
end
