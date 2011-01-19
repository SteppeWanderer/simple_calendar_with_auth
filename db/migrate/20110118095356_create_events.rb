class CreateEvents < ActiveRecord::Migration
  def self.up
    create_table :events do |t|
      t.references :user
      t.string :name
      t.datetime :start_at
      t.datetime :end_at
      
      t.timestamps
    end
    add_index("events", "user_id")
  end

  def self.down
    drop_table :events
  end
end
