class Task < ActiveRecord::Base
  belongs_to :priority
  belongs_to :iteration
  belongs_to :feature
  belongs_to :user
  extend PriorityFinders
  
  validates :name, :presence => true
  validates :description, :presence => true
  validates :priority_id, :presence => true
  
end
