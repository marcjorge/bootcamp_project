class Project < ActiveRecord::Base
	belongs_to :user
	has_many :tasks
	has_many :project_groups

	validates :name, presence: :true
	validates :description, presence: :true
	validates :user_id, presence: :true
	validates :deadline, presence: :true
	 
end
