class User < ActiveRecord::Base
	has_many :characters
	# has_many :bosses
	has_secure_password

	VALID_EMAIL_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i

	validates :username, presence: true, length: {maximum: 50}

	validates :email, presence: true, format: {with: VALID_EMAIL_REGEX}, uniqueness: true

end
