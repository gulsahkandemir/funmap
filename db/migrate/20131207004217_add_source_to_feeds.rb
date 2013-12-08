class AddSourceToFeeds < ActiveRecord::Migration
  def change
    add_column :feeds, :source, :string, :null => false, :default => 'sf_fun_cheap'
  end
end
