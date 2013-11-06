class Feed < ActiveRecord::Base
  belongs_to :actor
  has_many :feed_has_categories
  has_many :categories, through: :feed_has_categories
end