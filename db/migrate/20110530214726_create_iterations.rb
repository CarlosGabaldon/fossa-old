class CreateIterations < ActiveRecord::Migration
  def self.up
    create_table :iterations do |t|
      t.string :name
      t.text :description
      t.integer :days
      t.integer :feature_id

      t.timestamps
    end
  end

  def self.down
    drop_table :iterations
  end
end
