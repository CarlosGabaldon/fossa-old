class Project < ActiveRecord::Base
  has_many :features, :dependent => :destroy 
  belongs_to :priority
  
  validates :name, :presence => true
  validates :description, :presence => true
  validates :priority_id, :presence => true
  
  
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
    features.collect {|f| f.total_days }.sum
  end
end