module PriorityFinders
  
  def high_priority
    #logger.debug "high_priority called"
    find :all, :conditions => "priority_id = 1"
  end
  
  def med_priority
    find :all, :conditions => "priority_id = 2"
  end
  
  def low_priority
    find :all, :conditions => "priority_id = 3"
  end

end