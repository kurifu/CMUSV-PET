class ProjectsController < ApplicationController

#Displays all the projects on the Project Index page
  def index
    begin
      @projects = Project.all

      respond_to do |format|
        format.html # index.html.erb
        format.xml  { render :xml => @projects }
      end

      rescue Exception => ex
      @error_msg = "Cannot locate database, make sure it exists at 'db/development.sqlite3'"

      render "projects/error"
    end
  end

#Displays project details for the selected project
  def show
    begin
      @project = Project.find(params[:id])

      respond_to do |format|
        format.html # show.html.erb
        format.xml  { render :xml => @project }
      end

      rescue Exception => ex
      @error_msg = ex.message

      render "projects/error"
    end
  end


#Creates a new project
  def new
    begin
      @project = Project.new
      @lifecycle_array = RailblazersXmlParser.get_lifecycle
      @error_msg
      respond_to do |format|
        format.html # new.html.erb
        format.xml  { render :xml => @project }
      end
      
      rescue Exception => ex
      @error_msg = ex.message

      render "projects/error"
    end
  end

  def error
  end

# Note: this is for future story card
  def edit
    @project = Project.find(params[:id])
  end

#Creates a project
# Note: are we using this format for error handling?
  def create
    @project = Project.new(params[:project])
    
    respond_to do |format|
      if @project.save
        #puts "save successful"
        session[:project_id] = @project.id
        session[:phase] = "Planning"
        
        format.html { redirect_to :controller=> "deliverables" }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        #puts "save failed"
        @lifecycle_array = RailblazersXmlParser.get_lifecycle
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
    rescue ActiveRecord::StatementInvalid
      logger.error("Inable to reach table, invalid statement")
      flash[:notice]= "Invalid Statement"
      redirect_to :action => 'new'
  end

#Updates the selected project with the content as modified by the user
# Note: this is for future story card
  def update
    begin
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

      rescue Exception => ex
      @error_msg = ex.message

      render "projects/error"
    end
  end

#Deletes a project
# Note: this is for future story card
  def destroy
    begin
      @project = Project.find(params[:id])
      @project.deliverables.each { |d| d.destroy  }
      @project.destroy

      respond_to do |format|
        format.html { redirect_to(projects_url) }
        format.xml  { head :ok }
      end
      rescue Exception => ex
      @error_msg = ex.message

      render "projects/error"
    end
  end

  #TODO : delete in future iterations
  def integrate_with_delilverables
    session[:project_id] = params[:id]
    redirect_to :controller=>"deliverables"
  end

#View the project overview screen with phase/deliverable estimations
  def overview
    begin
      @project = Project.find_by_id(session[:project_id])
      @phase_efforts = {}

      phases = RailblazersXmlParser.get_phase(@project.lifecycle)
      deliverables = Deliverable.find_all_by_project_id(@project.id)

      # For each phase, create a new Hash if it doesn't exist
      0.upto(phases.size-1) do |i|
        unless @phase_efforts.has_key?(phases[i])
          @phase_efforts[phases[i]] = Hash.new

          # Grab all deliverables in this phase, add it to our small hash
          del_to_process = deliverables.select {|d| d.phase == phases[i] }
          del_to_process.each do |target|
            @phase_efforts[phases[i]][target.name] = target.estimated_effort
          end
        end
      end

      respond_to do |format|
        format.html
      end

      rescue Exception => ex
      @error_msg = ex.message

      render "projects/error"
    end
  end

end
