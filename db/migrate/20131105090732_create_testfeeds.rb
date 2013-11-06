class CreateTestfeeds < ActiveRecord::Migration
  def change
    create_table :testfeeds do |t|
      t.string :title

      t.timestamps
    end
  end
end
