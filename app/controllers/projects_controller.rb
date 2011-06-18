class ProjectsController < ApplicationController
  
  respond_to :html, :js
  
  def index
    get_projects
    get_priorities

    #respond_with [get_priorities, get_priorities]
  end

  def show
    @project = Project.find(params[:id])
    respond_with @project
  end

  def new
    @project = Project.new
    respond_with @project
  end

  def edit
    @project = Project.find(params[:id])
    get_priorities
    respond_with @project
  end

  def create
    @project = Project.new(params[:project])
    create_was_successful = @project.save
    
    respond_with @project do |format|
      if create_was_successful
        get_projects
        format.js
      else
        format.js
      end
    end
  end

  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        get_projects
        format.js # run the update.rjs template
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.js
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  def destroy
    @project = Project.find(params[:id])
    @removed_project = @project
    @project.destroy
    get_projects
    
    respond_to do |format|
      format.js
    end
  end
  
  # POST /projects/1/cancel
  def cancel
    @project = Project.find(params[:id])
  end
  
  private
  
  def get_projects
    @low_projects = Project.low_priority
    @med_projects = Project.med_priority
    @high_projects = Project.high_priority
    @projects = Project.find(:all)
  end
  
  def get_priorities
    @priorities = Priority.find(:all)
  end
end
