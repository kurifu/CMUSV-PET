class ProjectsController < ApplicationController
  # GET /projects
  # GET /projects.xml

  def index
    @projects = Project.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

  # GET /projects/1
  # GET /projects/1.xml
  def show
    @project = Project.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/new
  # GET /projects/new.xml
  def new
    @project = Project.new
    @lifecycle_array = Project.get_lifecycle
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  # GET /projects/1/edit
  def edit
    @project = Project.find(params[:id])
  end

  # POST /projects
  # POST /projects.xml
  def create
    @project = Project.new(params[:project])
    
    #@project.lifecycle = Lifecycle.find_by_id(@project.lifecycle_id)
    
    respond_to do |format|
      if @project.save
        # TODO:  save project_id if we edit existing project
        #       phase + overview + project home
        session[:project_id] = @project.id
        
        #format.html { redirect_to(@project, :notice => 'Project was successfully created.') }
        format.html { redirect_to("/deliverables/index") }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        # needed to render new
        @lifecycle_array = Project.get_lifecycle
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
    rescue ActiveRecord::StatementInvalid
      logger.error("Inable to reach table, invalid statement")
      flash[:notice]= "Invalid Statement"
      redirect_to :action => 'new'
  end

  # PUT /projects/1
  # PUT /projects/1.xml
  def update
    @project = Project.find(params[:id])

    respond_to do |format|
      if @project.update_attributes(params[:project])
        format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /projects/1
  # DELETE /projects/1.xml
  def destroy
    @project = Project.find(params[:id])
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end
end
