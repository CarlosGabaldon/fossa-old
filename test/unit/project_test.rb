require 'test_helper'

class ProjectTest < ActiveSupport::TestCase
  
  test "new project that has no features should be zero days to complete" do
    
    project = Project.new(:name => "Turtles for the environment",
                          :description => "Turtles want a website to help
                                          them save the planet.",
                          :priority_id => 1)
   
    unless project.save
      ::Rails.logger.debug project.errors
    end
    
    assert_equal 0, project.features.length
    assert_equal 0, project.total_days
    
  end
  
  test "project with one feature and no tasks should be zero days to complete" do
    
    project = Project.create(:name => "Hampster mind control",
                             :description => "Hampsters need a website that
                                           will help them control humans.",
                             :priority_id => 1)
   
    feature = Feature.new(:name => "Look into my eyes",
                          :description => "Section where humans look into 
                                           the eyes of their future rulers.")
    unless feature.save
      ::Rails.logger.debug feature.errors
    end
    
    project.features << feature
    
    unless project.save
      ::Rails.logger.debug project.errors 
    end
    
    assert_equal 1, project.features.length
    
  end
  
  test "proejct with one feature and one task should roll up days to complete" do
    
    project = Project.create(:name => "Elephant voting",
                             :description => "Website for Elephants who want 
                                              voting rights.",
                             :priority_id => 1)
   
    feature = Feature.create(:name => "Why it matters",
                            :description => "Section where elephants make their case
                                           for equality in voting rights.")
                                             
    iteration = Iteration.create(:name => "Phase 1",
                                 :description => "Initial phase to flush out core feature")
                                 
    feature.iterations << iteration
    
                                             
    task = Task.new(:name => "Meet with head elephant",
                    :description => "A few meetings with head elephant to learn
                                     what they are looking for with the website",
                    :days => 2,
                    :priority_id => 1,
                    :user_id => 1)  
                    
    unless task.save
      ::Rails.logger.debug task.errors
    end
    
    feature.tasks << task
    iteration.tasks << task                            
    
    unless feature.save
      ::Rails.logger.debug feature.errors
    end
    
    unless iteration.save
      ::Rails.logger.debug iteration.errors
    end
    
    project.features << feature
    
    unless project.save
      ::Rails.logger.debug project.errors 
    end

    assert_equal 2, project.total_days
    
    
  end
  
end
