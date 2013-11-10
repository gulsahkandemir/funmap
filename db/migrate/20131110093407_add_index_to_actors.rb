class AddIndexToActors < ActiveRecord::Migration
  def change
  	add_index :actors, :id_actor, :unique => true
  end
end
