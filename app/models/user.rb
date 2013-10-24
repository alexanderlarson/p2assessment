require 'bcrypt'

class User < ActiveRecord::Base
	include BCrypt
	
	validates :email, :password, presence: true
	validates :email, uniqueness: true
	validates :email, :format => { :with => /\A.+@.+\..+\z/, :message => "Please enter a valid email address"}

#-----------

	has_many :events

	has_many :event_attendances
	has_many :attended_events, through: :event_attendances, source: :event

	has_many :created_events, class_name: "Event"#, foreign_key: :creator_id

#-----------

	def password
      @password ||= Password.new(password_digest)
    end

    def password=(new_password)
      @password = Password.create(new_password)
      self.password_digest = @password
    end

    def self.authenticate(args)
      user = User.find_by_email(args[:email])
      return user if user && (user.password == args[:password])
    	nil
  	end

end
