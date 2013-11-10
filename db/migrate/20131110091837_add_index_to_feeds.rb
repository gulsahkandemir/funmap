class AddIndexToFeeds < ActiveRecord::Migration
  def change
    add_index :feeds, :id_feed, :unique => true
  end
end
