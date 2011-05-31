class CreateFeatures < ActiveRecord::Migration
  def self.up
    create_table :features do |t|
      t.string :name
      t.text :description
      t.integer :priority_id
      t.integer :project_id
      t.boolean :completed, :default => false

      t.timestamps
    end
  end

  def self.down
    drop_table :features
  end
end
