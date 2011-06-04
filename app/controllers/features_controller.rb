class FeaturesController < ApplicationController
  before_filter :load_project
  # GET /features
  # GET /features.xml
  def index
    get_features
    @priorities = Priority.find(:all)

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @features }
    end
  end

  # GET /features/1
  # GET /features/1.xml
  def show
    @feature = Feature.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @feature }
    end
  end

  # GET /features/new
  # GET /features/new.xml
  def new
    @feature = Feature.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @feature }
    end
  end

  # GET /features/1/edit
  def edit
    @feature = Feature.find(params[:id])
    @priorities = Priority.find(:all)
  end

  # POST /features
  # POST /features.xml
  def create
    @feature = Feature.new(params[:feature])

    respond_to do |format|
      
      if @feature.save
        @project.features << @feature
        @project.save
        get_features
        format.js
      else
        format.js
        format.html { render :action => "new" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /features/1
  # PUT /features/1.xml
  def update
    @feature = Feature.find(params[:id])

    respond_to do |format|
      if @feature.update_attributes(params[:feature])
        get_features
        format.js
        format.html { redirect_to(@feature, :notice => 'Feature was successfully updated.') }
        format.xml  { head :ok }
      else
        format.js
        format.html { render :action => "edit" }
        format.xml  { render :xml => @feature.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /features/1
  # DELETE /features/1.xml
  def destroy
    @feature = Feature.find(params[:id])
    @removed_feature = @feature
    @feature.destroy
    get_features

    respond_to do |format|
      format.html { redirect_to(features_url) }
      format.xml  { head :ok }
      fomat.js
    end
  end
  
  # POST /features/1;cancel
  # To generate url #=> cancel_feature_path(feature); link_to_remote also needs #=> :method => :get 
  # Needed in routes.rb #=> map.resources :features, :member => {:cancel => :get}
  def cancel
    @feature = Feature.find(params[:id])
  end
  
  private
  
  def load_project
     @project = Project.find params[:project_id]
  end
  
  def get_features
    @low_features = @project.features.low_priority
    @med_features = @project.features.med_priority
    @high_features = @project.features.high_priority
  end
end
