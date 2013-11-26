class Category < ActiveRecord::Base
	has_many :feed_has_categories
	has_many :feeds, through: :feed_has_categories

    Excluded_Categories = [13,18,22]
end
