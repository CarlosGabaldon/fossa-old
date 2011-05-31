class Iteration < ActiveRecord::Base
  has_many :tasks
  belongs_to :feature
  
  def total_days
    tasks.sum(:days) || 0
  end
end