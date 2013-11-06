class CreateActors < ActiveRecord::Migration
  def change
    create_table :actors do |t|
      t.string :display_name
      t.string :permalink_url
      t.string :id_actor

      t.timestamps
    end
  end
end
