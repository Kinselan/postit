class User < ActiveRecord::Base
	include Sluggable

	has_many :posts
	has_many :comments
	has_many :votes

	has_secure_password validations: false

	validates :username, presence: true, uniqueness: true
	validates :password, presence: true, on: :create, length: {minimum: 5} #password is a virtual attribute
	#without on: :create, you need a password when modifying, even if not changing password

	sluggable_column :username

	def admin?
		self.role == 'admin'
	end

	def moderator?
		self.role == 'moderator'
	end
end
