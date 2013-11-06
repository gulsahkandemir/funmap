class FeedHasCategory < ActiveRecord::Base
  belongs_to :feed
  belongs_to :category
end
