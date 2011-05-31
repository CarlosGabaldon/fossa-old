class Feature < ActiveRecord::Base
  belongs_to :priority
  belongs_to :project
  has_many :iterations
  has_many :tasks, :dependent => :destroy 
  
  def self.high_priority
    find :all, :conditions => "priority_id = 1"
    
  end
  
  def self.med_priority
    find :all, :conditions => "priority_id = 2"
  end
  
  def self.low_priority
    find :all, :conditions => "priority_id = 3"
  end
  
  def total_days
    tasks.sum(:days) || 0
  end
  
end