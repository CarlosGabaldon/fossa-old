class ProjectsController < ApplicationController
  
  respond_to :html, :js
  
  # GET /projects
  # GET /projects.xml
  def index
    get_projects
    get_priorities

    respond_with [get_priorities, get_priorities]
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_with @project
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
    get_priorities
    
    respond_with @project
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    

    respond_to do |format|
      if @project.save
        get_projects
        format.js
      else
        format.js
      end
    end
  end

  # PUT /projects/1
  # PUT /projects/1.xml
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

  # DELETE /projects/1
  # DELETE /projects/1.xml
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
