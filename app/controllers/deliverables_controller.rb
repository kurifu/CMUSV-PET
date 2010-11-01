class DeliverablesController < ApplicationController

#Populates static data and creates a new instance of Deliverable class and 
#binds the @deliverable variable with the form element of Phase page
  def index
    project_id = session[:project_id]
    lifecycle = Project.find(project_id).lifecycle

    #@deliverable is used to bind with the select tag.
    #When value assigned to the phases attribute, it become the selected value in select tag
    @deliverable = Deliverable.new
    
    @phases = RailblazersXmlParser.get_phase(lifecycle)

    if params[:phase].nil?
      session[:phase] = nil
      @deliverables_of_phase = []#Project.find(session[:project_id]).deliverables.find_all_by_phase("Requirements Gathering And Analysis")
      @deliverable_types =[]
    else
      session[:phase] = params[:phase]
      @deliverable.phase = params[:phase]
      @deliverables_of_phase = Project.find(project_id).deliverables.find_all_by_phase(params[:phase])
      dtype_id = RailblazersXmlParser.identify_deliverable_type(params[:phase])
      @deliverable_types = RailblazersXmlParser.get_deliverable_type(dtype_id)
    end

  end


# This is an AJAX function which updates the Phase table and the Deliverable Type dropdown
#list based on the phase selected in the Phase dropdown list
  def update_deliverable_partial
    if params[:phase].blank?
      flash[:notice] = "Please select a phase"
      redirect_to :action => "index"
    else
      @deliverables_of_phase = Project.find(session[:project_id]).deliverables.find_all_by_phase(params[:phase])
      dtype_id = RailblazersXmlParser.identify_deliverable_type(params[:phase])
      @deliverable_types = RailblazersXmlParser.get_deliverable_type(dtype_id)
      session[:phase] = params[:phase]
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
