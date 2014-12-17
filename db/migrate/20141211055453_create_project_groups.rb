class CreateProjectGroups < ActiveRecord::Migration
  def change
    create_table :project_groups do |t|

      t.timestamps
    end
  end
end
