class Feature < ActiveRecord::Base
  belongs_to :priority
  belongs_to :project
  has_many :iterations
  has_many :tasks, :dependent => :destroy 
  extend PriorityFinders
  
  validates :name, :presence => true
  validates :description, :presence => true
  validates :priority_id, :presence => true
  
  def total_days
    tasks.sum(:days) || 0
  end
  
end