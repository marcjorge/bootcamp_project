class AddProjectIdToProjectGroup < ActiveRecord::Migration
  def change
    add_column :project_groups, :project_id, :integer
  end
end
