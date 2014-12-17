class User < ActiveRecord::Base
	attr_accessor :password

	has_many :projects
	has_many :calendars
	has_many :project_groups
	before_save :encrypt_password
	after_save	:clear_password

	EMAIL_REGEX = /\A^[a-zA-Z\d]+[@][a-zA-Z\d]+[.][a-zA-Z\d]{3}$\z/
	validates :first_name, presence: true, format: { with:/\A[a-zA-Z]+\z/,
   				message: "only allows letters" }
	validates :last_name, presence: true, format: { with: /\A[a-zA-Z]+\z/,
    			message: "only allows letters" }
	validates :email, presence: true, uniqueness: true, format: EMAIL_REGEX
	validates :username, presence: true, uniqueness: true
	validates :password, confirmation: true, length: { minimum: 6 }, on: :create
	validates :password_confirmation, presence: true, on: :create

	def self.authenticate(username_or_email="", login_password="")
    if  EMAIL_REGEX.match(username_or_email)    
      user = User.find_by_email(username_or_email)
    else
      user = User.find_by_username(username_or_email)
    end

    if user && user.match_password(login_password)
      return user
    else
      false
    end
  end   

  def match_password(login_password="")
    encrypted_password == BCrypt::Engine.hash_secret(login_password, salt)
  end

	def encrypt_password
	  if password.present?
	    self.salt = BCrypt::Engine.generate_salt
	    self.encrypted_password= BCrypt::Engine.hash_secret(password, salt)
	  end
	end

	def clear_password
	  self.password = nil
	end

end
