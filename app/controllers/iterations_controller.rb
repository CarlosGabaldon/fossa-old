class IterationsController < ApplicationController
  before_filter :load_project_feature_resources
  # GET /iterations
  # GET /iterations.xml
  def index
    get_iterations

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @iterations }
    end
  end

  # GET /iterations/1
  # GET /iterations/1.xml
  def show
    @iteration = Iteration.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @iteration }
    end
  end

  # GET /iterations/new
  # GET /iterations/new.xml
  def new
    @iteration = Iteration.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @iteration }
    end
  end

  # GET /iterations/1/edit
  def edit
    @iteration = Iteration.find(params[:id])
  end

  # POST /iterations
  # POST /iterations.xml
  def create
    @iteration = Iteration.new(params[:iteration])

    respond_to do |format|
      if @iteration.save
        @feature.iterations << @iteration
        @feature.save
        get_iterations
        format.js
        format.html { redirect_to(@iteration, :notice => 'Iteration was successfully created.') }
        format.xml  { render :xml => @iteration, :status => :created, :location => @iteration }
      else
        format.js
        format.html { render :action => "new" }
        format.xml  { render :xml => @iteration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /iterations/1
  # PUT /iterations/1.xml
  def update
    @iteration = @feature.iterations.find(params[:id])

    respond_to do |format|
      if @iteration.update_attributes(params[:iteration])
        format.js
        format.html { redirect_to(@iteration, :notice => 'Iteration was successfully updated.') }
        format.xml  { head :ok }
      else
        format.js
        format.html { render :action => "edit" }
        format.xml  { render :xml => @iteration.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /iterations/1
  # DELETE /iterations/1.xml
  # To generate url #=> iteration_path(iteration); link_to_remote also needs #=> :method => :delete 
  def destroy
    @iteration = @feature.iterations.find(params[:id])
    @removed_iteration = @iteration
    @iteration.destroy
    get_iterations
    
    respond_to do |format|
      format.js
      format.html { redirect_to(iterations_url) }
      format.xml  { head :ok }
    end
  end
  
  # POST /iterations/1;cancel
   # To generate url #=> cancel_iteration_path(@project, @feature, iteration); link_to_remote also needs #=> :method => :get 
   # Needed in routes.rb #=> map.resources :iterations, :member => {:cancel => :get}
  def cancel
    @iteration = Iteration.find(params[:id])
  end
  
  private
  
  def get_iterations
     @iterations = @feature.iterations.find(:all)
  end
  
  def load_project_feature_resources
    @feature = Feature.find params[:feature_id]
    @project = Project.find params[:project_id]
  end
end
