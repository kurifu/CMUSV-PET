class DeliverablesController < ApplicationController
before_filter :require_user
#Populates static data and creates a new instance of Deliverable class and 
#binds the @deliverable variable with the form element of Phase page
#the index page also handling with parameters. user can navigate from the
#project overview screen
  def index
    #@deliverable is used to bind with the select tag.
    #When value assigned to the phases attribute, it become the selected value in select tag
    session[:project_id] = params[:project_id]
    @deliverable = Deliverable.new
    if current_user_admin
      @project = Project.find(session[:project_id])
    else
      @project = current_user.projects.find(session[:project_id])
    end
    project_id = session[:project_id]
    lifecycle = Project.find(project_id).lifecycle

    @phases = RailblazersXmlParser.get_phase(lifecycle)
    #Handling situation when user come to this page through project overview
    if params[:default_phase].blank?
      session[:phase] = nil
      @deliverables_of_phase = []
    else
      @deliverable.phase = session[:phase] = params[:default_phase]
      @deliverables_of_phase = Project.find(project_id).deliverables.find_all_by_phase(params[:default_phase])
    end
  end

  def add_attachment
    @deliverable = Deliverable.find(params[:id])
    @project = Project.find(@deliverable.project_id)
  end

  def update
    @deliverable = Deliverable.find(params[:id])
    
    # Needed incase deliverable is nil from an empty submission
    @attachment = params[:deliverable]

    unless @attachment.nil?
      if @deliverable.update_attributes(params[:deliverable])
        flash[:notice] = "Deliverable successfully uploaded!"
        redirect_to :controller => :deliverables,
          :action => :index,
          :default_phase => @deliverable.phase
        return
      end
    end
    flash[:notice] = "Deliverable did not upload correctly!"
    redirect_to :controller => :deliverables,
      :action => :add_attachment,
      :id => @deliverable.id
  end

# This is an AJAX function which updates the Phase table and the Deliverable Type dropdown
#list based on the phase selected in the Phase dropdown list
  def update_deliverable_partial
    @phase = params[:phase]
    if @phase.blank?
      flash[:notice] = "Please select a phase"
      redirect_to :action => "index"
    else

      @deliverables_of_phase = Project.find(session[:project_id]).deliverables.find_all_by_phase(@phase)

      #use session[:phase] to store phase for the use in deliverable_type_controller,
      #we need to clean up this session when it is not needed
      session[:phase] = params[:phase]
      session[:deliverable_type_id] = RailblazersXmlParser.identify_deliverable_type(params[:phase])
      render :update do |page|
        page.replace_html 'phase_partial', :partial => 'deliverable_partial', :object => @deliverables_of_phase
      end
    end
  end

#Validates the presence of phase in the Phase dropdown list
  def validate_before_adding_new_type
    if session[:phase].blank?
      flash[:notice] = "Please select a phase"
      redirect_to :action => "index"
    else
      redirect_to :controller => "deliverable_type", :action => "new"
    end
  end

end
