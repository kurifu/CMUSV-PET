class ProjectsController < ApplicationController
before_filter :require_user
  #Displays all the projects on the Project Index page
  #it will only display projects belongs to the current user
  #This prevents the user from guessing the url
  def index
    @projects = current_user.projects.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @projects }
    end
  end

#Displays project details for the selected project
#The show page now shows a list of deliverable and displays the effort for the
#deliverables
  def show
    if current_user_admin
      @project = Project.find(params[:id])
    else
      @project = current_user.projects.find(params[:id])
    end
    session[:project_id] = params[:id]
    @deliverables = Deliverable.find(:all, :conditions => ["project_id = ?", params[:id]], :order => "phase")

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @project }
    end
  end


#Creates a new project
  def new
    @project = Project.new
    @lifecycle_array = RailblazersXmlParser.get_lifecycle
    @error_msg
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @project }
    end
  end

  def error
  end

#Edit an existing project. If the current user is admin. He can edit all the
#projects in the system. If it is regular user, PET will only allow this type
#of user to access the project belongs to the user
  def edit
    if current_user_admin
      @project = Project.find(params[:id])
    else
      @project = current_user.projects.find(params[:id])
    end
  end

#Creates a project
  def create
    @project = Project.new(params[:project])
    @project.user_id = current_user.id
    
    respond_to do |format|
      if @project.save
        #puts "save successful"
        session[:project_id] = @project.id
        session[:phase] = "Planning"
        
        format.html { redirect_to :controller=> "deliverables", :project_id=>@project.id }
        format.xml  { render :xml => @project, :status => :created, :location => @project }
      else
        #puts "save failed"
        @lifecycle_array = RailblazersXmlParser.get_lifecycle
        format.html { render :action => "new" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

#Updates the selected project with the content as modified by the user
  def update
    if current_user_admin
      @project = Project.find(params[:id])
    else
      @project = current_user.projects.find(params[:id])
    end

    respond_to do |format|
      if @project.update_attributes(params[:project])
        if current_user_admin
          format.html { redirect_to(admin_projects_path, :notice => 'Project was successfully updated.') }
        else
          format.html { redirect_to(:controller=>"projects", :notice => 'Project was successfully updated.') }
        end
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
      end
    end
  end

#Deletes a project
#When deleting a project all the deliverables related to the project will be
#deleted too
  def destroy
    if current_user_admin
      @project = Project.find(params[:id])
    else
      @project = current_user.projects.find(params[:id])
    end
    @project.deliverables.each { |d| d.destroy  }
    @project.destroy

    respond_to do |format|
      format.html { redirect_to(projects_url) }
      format.xml  { head :ok }
    end
  end

#View the project overview screen with phase/deliverable estimations
  def overview
    @project = current_user.projects.find_by_id(session[:project_id])
    @phase_efforts = {}

    phases = RailblazersXmlParser.get_phase(@project.lifecycle)
    deliverables = Deliverable.find_all_by_project_id(@project.id)

    # For each phase, create a new Hash if it doesn't exist
    0.upto(phases.size-1) do |i|
      unless @phase_efforts.has_key?(phases[i])
        @phase_efforts[phases[i]] = Hash.new

        # Grab all deliverables in this phase, add it to our small hash
        del_to_process = deliverables.find_all {|d| d.phase == phases[i] }
        del_to_process.each do |target|
          @phase_efforts[phases[i]][target.id] = [target.name,target.estimated_effort,target.hours_logged]
        end
      end
    end

    respond_to do |format|
      format.html
    end
  end

  #Action to log hours for a particular deliverable.
  def log_hours
    @project = current_user.projects.find(params[:project_id])
    @target_del = Deliverable.find(params[:deliverable_id])
    @deliverables = Deliverable.find(:all, :conditions => ["project_id = ?", params[:project_id]], :order => "phase")
    @hours = params[:deliverable][:hours_logged]

    unless @hours.blank?
      @target_del.hours_logged = @hours
      puts "type of: '#{@hours.class}'"
      if (@hours.is_a? Float) || (@hours.is_a? Integer)
        puts "Number"
      else
        puts "Not number"
      end
      
        if @target_del.save
          flash[:notice] = "Effort Updated"
        else
          flash[:notice] = "Error Saving! Changes discarded"
        end
    else
      flash[:notice] = "Please enter a value before submitting"
    end
    redirect_to :controller => :projects, :action => :show, :id => params[:project_id]
  end

  def is_num?(s)
    s.to_s.match(/\A[+-]?\d+?(\.\d+)?\Z/) == nil ? false : true
  end
end
