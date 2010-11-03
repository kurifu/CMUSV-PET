#Deliverables Controller
class DeliverableTypeController < ApplicationController

  before_filter :initialize_for_selects
  attr_accessor :notice_calc

#The method #new creates a new instance of Deliverable and binds the @deliverable variable 
#with the form element in the new.html.erb file

  def new
    begin
      @deliverable = Deliverable.new

      respond_to do |format|
        format.html
      end

      rescue Exception => ex
      @error_msg = ex.message

      render "projects/error"
    end
  end

#Fetches user input from new.html.erb and saves the data on the database
  def create
    begin
      @deliverable = Deliverable.new(params[:deliverable])
      
      @deliverable.phase = session[:phase]
      @deliverable.project_id = session[:project_id]

      #Code containing entered information when create fails they will be used in the view
      @estimated_size = params[:deliverable][:estimated_size] || '' unless params[:deliverable].nil?
      @production_rate = params[:deliverable][:production_rate] || '' unless params[:deliverable].nil?
      @estimated_effort = params[:deliverable][:estimated_effort] || '' unless params[:deliverable].nil?

      respond_to do |format|
        if @deliverable.save
          format.html{ redirect_to :controller => "deliverables", :action=>"index", :default_phase=>session[:phase] }
        else
          format.html{ render :action => "new", :status => :unprocessable_entity}
        end
      end
      
      rescue Exception => ex
      @error_msg = ex.message

      render "projects/error"
    end
  end

#This method initializes the static content to be populated in the dropdown lists
  private
  def initialize_for_selects
    begin
      @deliverable_types = RailblazersXmlParser.get_deliverable_type(RailblazersXmlParser.identify_deliverable_type("System Design"))
      @complexities = RailblazersXmlParser.get_common_values
      @estimated_sizes = RailblazersXmlParser.get_common_values
      @production_rates = RailblazersXmlParser.get_common_values
      @efforts = RailblazersXmlParser.get_common_values

    rescue Exception => ex
      @error_msg = ex.message

      render "projects/error"
    end
  end
end
