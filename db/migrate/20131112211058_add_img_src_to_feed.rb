class AddImgSrcToFeed < ActiveRecord::Migration
  def change
    add_column :feeds, :img_src, :string
  end
end
