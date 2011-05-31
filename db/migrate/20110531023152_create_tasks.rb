class CreateTasks < ActiveRecord::Migration
  def self.up
    create_table :tasks do |t|
      t.string :name
      t.text :description
      t.integer :priority_id
      t.integer :feature_id

      t.timestamps
    end
  end

  def self.down
    drop_table :tasks
  end
end
