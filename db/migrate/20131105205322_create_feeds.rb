class CreateFeeds < ActiveRecord::Migration
  def change
    create_table :feeds do |t|
      t.string :id_feed
      t.float :published
      t.float :updated
      t.string :title
      t.text :summary
      t.text :content
      t.string :permalink_url
      t.references :actor, index: true

      t.timestamps
    end
  end
end
