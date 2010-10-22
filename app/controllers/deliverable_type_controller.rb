#Deliverables Controller
class DeliverableTypeController < ApplicationController

  before_filter :initialize_for_selects

#The method #new creates a new instance of Deliverable and binds the @deliverable variable 
#with the form element in the new.html.erb file

  def new
    @deliverable = Deliverable.new
    respond_to do |format|
      format.html
    end
  end

#Fetches user input from new.html.erb and saves the data on the database
  def create
    @deliverable = Deliverable.new(params[:deliverable])
    @deliverable.project_id = session[:project_id]
    @deliverable.phase = session[:phase]

    respond_to do |format|
      if @deliverable.save
        format.html{ redirect_to :controller => "deliverables" }
      else
        format.html{ render :action => "new", :status => :unprocessable_entity}

      end
    end
  end

  #This solution probably need to be refactored
  #Capture data from the estimated_size, production_rate and estimated_effort
  def capture_calculation_data
    #test code
    puts params[:estimated_size]
    puts params[:field]

    field = params[:field]
    if field == '1'
      session[:estimated_size]=params[:estimated_size]
    elsif field == '2'
      session[:production_rate]=params[:production_rate]
    elsif field == '3'
      session[:estimated_effort]=params[:estimated_effort]
    end

    #test code
    puts session[:estimated_size]
    puts session[:production_rate]
    puts session[:estimated_effort]
  end

  #It only handle one situation now
  def process_calc_inputs
    production_rate = session[:production_rate].to_f
    estimated_size = session[:estimated_size].to_f
    session[:estimated_effort] = production_rate+estimated_size
    render :partial=>'pet_calc'
  end

#This method initializes the static content to be populated in the dropdown lists
  private
  def initialize_for_selects
    @deliverable_types = RailblazersXmlParser.get_deliverable_type(RailblazersXmlParser.identify_deliverable_type("System Design"))
    @complexities = RailblazersXmlParser.get_common_values
    @estimated_sizes = RailblazersXmlParser.get_common_values
    @production_rates = RailblazersXmlParser.get_common_values
    @efforts = RailblazersXmlParser.get_common_values
  end
end
