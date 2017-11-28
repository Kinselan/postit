class Vote < ActiveRecord::Base
  belongs_to :creator, class_name: 'User', foreign_key: 'user_id'

  # we can't say belongs_to :post, because we don't know what this vote belongs to.
  # instead, utilize polymorphism
  belongs_to :voteable, polymorphic: true

  validates_uniqueness_of :creator, scope: [:voteable_id, :voteable_type]
end
