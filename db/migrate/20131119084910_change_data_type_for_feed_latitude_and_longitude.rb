class ChangeDataTypeForFeedLatitudeAndLongitude < ActiveRecord::Migration
 def self.up
    change_table :feeds do |t|
      t.change :latitude, :decimal, precision: 15, scale: 12
      t.change :longitude, :decimal, precision: 15, scale: 12
    end
  end
 
  def self.down
    change_table :feeds do |t|
      t.change :latitude, :float
      t.change :longitude, :float
    end
  end
end
