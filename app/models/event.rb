class Event < ActiveRecord::Base
	belongs_to :user
	#belongs_to :creator, class_name: "User"

	has_many :event_attendances
	has_many :attendees, through: :event_attendances, source: :user
end
