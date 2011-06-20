class Project < ActiveRecord::Base
  has_many :features, :dependent => :destroy 
  belongs_to :priority
  extend PriorityFinders
  
  validates :name, :presence => true
  validates :description, :presence => true
  validates :priority_id, :presence => true
  
  
  def total_days
    features.collect {|f| f.total_days }.sum
  end
end