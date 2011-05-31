class Task < ActiveRecord::Base
  belongs_to :priority
  belongs_to :iteration
  belongs_to :feature
  #belongs_to :user
  
  def self.high_priority
    find :all, :conditions => "priority_id = 1"
  end
  
  def self.med_priority
    find :all, :conditions => "priority_id = 2"
  end
  
  def self.low_priority
    find :all, :conditions => "priority_id = 3"
  end
end