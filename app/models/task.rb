class Task < ActiveRecord::Base
	belongs_to :project
	belongs_to :user

	validates :name, presence: true
	validates :description, presence: true
end