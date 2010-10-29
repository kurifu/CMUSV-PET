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

    #Code containing entered information when create fails they will be used in the view
    @estimated_size = params[:deliverable][:estimated_size] || '' unless params[:deliverable].nil?
    @production_rate = params[:deliverable][:production_rate] || '' unless params[:deliverable].nil?
    @estimated_effort = params[:deliverable][:estimated_effort] || '' unless params[:deliverable].nil?


    respond_to do |format|
      if @deliverable.save
        format.html{ redirect_to :controller => "deliverables" }
      else
        format.html{ render :action => "new", :status => :unprocessable_entity}

      end
    end
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
