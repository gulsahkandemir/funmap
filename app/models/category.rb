class Category < ActiveRecord::Base
	has_many :feed_has_categories
	has_many :feeds, through: :feed_has_categories

    def self.excluded_category_ids
        [13,18,22]
    end
end
