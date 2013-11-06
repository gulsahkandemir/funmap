class CreateFeedHasCategories < ActiveRecord::Migration
  def change
    create_table :feed_has_categories do |t|
      t.references :feed, index: true
      t.references :category, index: true

      t.timestamps
    end

	add_index :feed_has_categories, [:feed_id, :category_id], :unique => true
  end
end
