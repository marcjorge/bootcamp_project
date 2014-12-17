class Calendar < ActiveRecord::Base
	belongs_to :user
	has_many :holidays

	validates_uniqueness_of :date, scope: :user_id

end
