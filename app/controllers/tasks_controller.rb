class TasksController < ApplicationController
  before_filter :load_project_feature_iteration_resources
  # GET /tasks
  # GET /tasks.xml
  def index
    get_tasks
    get_priorities
    get_users

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.xml
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.xml
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    get_priorities
    get_users
  end

  # POST /tasks
  # POST /tasks.xml
  def create
    @task = Task.new(params[:task])

    respond_to do |format|
      if @task.save
        @feature.tasks << @task
        @iteration.tasks << @task
        @feature.save
        @iteration.save
        get_tasks
        format.js
        format.html { redirect_to(@task, :notice => 'Task was successfully created.') }
        format.xml  { render :xml => @task, :status => :created, :location => @task }
      else
        format.js
        format.html { render :action => "new" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.xml
  def update
    @task = Task.find(params[:id])

    respond_to do |format|
      if @task.update_attributes(params[:task])
        get_tasks
        format.js
        format.html { redirect_to(@task, :notice => 'Task was successfully updated.') }
        format.xml  { head :ok }
      else
        format.js
        format.html { render :action => "edit" }
        format.xml  { render :xml => @task.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.xml
  def destroy
    @task = Task.find(params[:id])
    @removed_task = @task
    @task.destroy
    get_tasks

    respond_to do |format|
      format.js
      format.html { redirect_to(tasks_url) }
      format.xml  { head :ok }
    end
  end
  
   # POST /tasks/1;cancel
   # To generate url #=> cancel_task_path(task); link_to_remote also needs #=> :method => :get 
   # Needed in routes.rb #=> map.resources :tasks, :member => {:cancel => :get}
   def cancel
     @task = Task.find(params[:id])
   end
  
  private
  
  def load_project_feature_iteration_resources
    @feature = Feature.find params[:feature_id]
    @project = Project.find params[:project_id]
    @iteration = Iteration.find params[:iteration_id]
  end
  
  def get_tasks
    @low_tasks = @feature.tasks.low_priority
    @med_tasks = @feature.tasks.med_priority
    @high_tasks = @feature.tasks.high_priority
    @tasks = Task.find(:all)
  end
  
  def get_priorities
    @priorities = Priority.find(:all)
  end
  
  #def get_users
  #  @users = User.find(:all)
  #end
  
end
