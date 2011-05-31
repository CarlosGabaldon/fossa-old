class CreatePriorities < ActiveRecord::Migration
  def self.up
    create_table :priorities do |t|
      t.string :name

      t.timestamps
    end
    
    Priority.create(:name => "High")
    Priority.create(:name => "Med")
    Priority.create(:name => "Low")
    
  end

  def self.down
    drop_table :priorities
  end
end
