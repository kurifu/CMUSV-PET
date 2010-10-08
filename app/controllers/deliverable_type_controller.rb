class DeliverableTypeController < ApplicationController

  before_filter :initialize_for_selects

  def new
    @deliverable = Deliverable.new
    respond_to do |format|
      format.html
    end
  end

  def create
    @deliverable = Deliverable.new(params[:deliverable])

    # TODO: swap these for integration testing
    #@deliverable.project_id = session[:project_id]
    @deliverable.project_id = session[:project_id]
    @deliverable.phase = session[:phase]

    respond_to do |format|
      if @deliverable.save
        format.html{ redirect_to :controller => "deliverables" }
      else
        format.html{ render :action => "new", :status => :unprocessable_entity}
        #format.xml { render :xml => @deliverable.errors, :status => :unprocessable_entity }
      end
    end
  end

  def process_calc_inputs
    puts "HI"
  end

  private
  def initialize_for_selects
    @deliverable_types = RailblazersXmlParser.get_deliverable_type(RailblazersXmlParser.identify_deliverable_type("System Design"))
    @complexities = RailblazersXmlParser.get_common_values
    @estimated_sizes = RailblazersXmlParser.get_common_values
    @production_rates = RailblazersXmlParser.get_common_values
    @efforts = RailblazersXmlParser.get_common_values
  end
end
