class DeliverablesController < ApplicationController

#Populates static data and creates a new instance of Deliverable class and 
#binds the @deliverable variable with the form element of Phase page
#the index page also handling with parameters. user can navigate from the
#project overview screen
  def index
    #@deliverable is used to bind with the select tag.
    #When value assigned to the phases attribute, it become the selected value in select tag
    @deliverable = Deliverable.new
    
    project_id = session[:project_id]
    lifecycle = Project.find(project_id).lifecycle

    #RailblazersXmlParser.initialize
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
    puts "-----------------in add_attachment"
    @deliverable = Deliverable.find(params[:id])
  end

  def update
    @deliverable = Deliverable.find(params[:id])

    puts "params is: #{params[:deliverable]}"
    
    del = params[:deliverable]
    
    puts "del id: #{params[:id]}"

    if @deliverable.update_attributes(params[:deliverable])
      puts "updated correctly, before update_deliverable_partial"
      #format.html { redirect_to(@project, :notice => 'Project was successfully updated.') }
      #format.xml  { head :ok }

      #update_deliverable_partial
      #render(:partial => 'deliverable_partial',
      #  :layout => false)
      redirect_to :controller=>'deliverables', :action=>'index', :default_phase=>@deliverable.phase
    else
      puts "did not update correctly"
      render :nothing => true
      #format.html { render :action => "edit" }
      #format.xml  { render :xml => @project.errors, :status => :unprocessable_entity }
    end

  end

# This is an AJAX function which updates the Phase table and the Deliverable Type dropdown
#list based on the phase selected in the Phase dropdown list
  def update_deliverable_partial
    if params[:phase].blank?
      flash[:notice] = "Please select a phase"
      redirect_to :action => "index"
    else
      puts "CHECK project id: #{session[:project_id]}"
      puts "CHECK project id: #{params[:phase]}"
      @deliverables_of_phase = Project.find(session[:project_id]).deliverables.find_all_by_phase(params[:phase])
      puts "size of @deliverables_of_phase: #{@deliverables_of_phase.size}"
      puts "@deliverables_of_phase: #{@deliverables_of_phase}"

      #use session[:phase] to store phase for the use in deliverable_type_controller,
      #we need to clean up this session when it is not needed
      session[:phase] = params[:phase]
      session[:deliverable_type_id] = RailblazersXmlParser.identify_deliverable_type(params[:phase])
      #puts "CHECK #{session[:deliverable_type_id]}"
      puts "\tbefore render partial"

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
