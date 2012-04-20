class Iteration < ActiveRecord::Base
  has_many :tasks
  belongs_to :feature
  
  validates :name, :presence => true
  validates :description, :presence => true
  #validates :days, :presence => true
  
  
  def total_days
    tasks.sum(:days) || 0
  end
end