class Post < ActiveRecord::Base
	belongs_to :creator, foreign_key: 'user_id', class_name: 'User'
	has_many :comments
	has_many :post_categories
	has_many :categories, through: :post_categories

	# below tells rails that the foreign key is not post_id, instead it is
	# a combinatino of voteable_type and voteable_id
	has_many :votes, as: :voteable

	validates :title, 			presence: true, length: {minimum: 5}
	validates :url, 				presence: true, uniqueness: true
	validates :description, presence: true


	def total_votes
		up_votes - down_votes
	end

	def up_votes
		self.votes.where(vote: true).size
	end

	def down_votes
		self.votes.where(vote: false).size
	end
end
