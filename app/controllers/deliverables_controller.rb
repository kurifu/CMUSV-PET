class DeliverablesController < ApplicationController

  # Phase Page
  def index
    @deliverable = Deliverable.new
    project_id = session[:project_id]
    lifecycle = Project.find(project_id).lifecycle
    @phases = Project.get_phase(lifecycle)
    @deliverables_of_phase = []#Project.find(session[:project_id]).deliverables.find_all_by_phase("Requirements Gathering And Analysis")
    @test = "in index"
  end

  def update_deliverable_partial
    @deliverables_of_phase = Project.find(session[:project_id]).deliverables.find_all_by_phase(params[:phase])
    @test = params[:phase]
    render :update do |page|
      page.replace_html 'phase_partial', :partial => 'deliverable_partial', :object => @deliverables_of_phase
    end
  end

  def submit
    session[:phase] = params[:phase]
    #TODO
  end
end
