#Deliverables Controller
class DeliverableTypeController < ApplicationController

  @@ADHOC = "Ad-Hoc Type"

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

      redirect_to "deliverable_type/error"
    end
  end

#Fetches user input from new.html.erb and saves the data on the database
  def create
    begin

      @deliverable = Deliverable.new(params[:deliverable])

      if @deliverable.deliverable_type == @@ADHOC
        @deliverable.ad_hoc = true
      else
        @deliverable.ad_hoc = false
      end

      @deliverable.phase = session[:phase]
      @deliverable.project_id = session[:project_id]

      #Code containing entered information when create fails they will be used in the view
      @estimated_size = @deliverable.estimated_size || '' 
      @production_rate = @deliverable.production_rate || '' 
      @estimated_effort = @deliverable.estimated_effort || '' 
      
      respond_to do |format|
        if @deliverable.save
          format.html{ redirect_to :controller => "deliverables", :default_phase=>session[:phase] }
        else
          format.html{ render :action => "new", :status => :unprocessable_entity}
        end
      end
      
      rescue Exception => ex
      @error_msg = ex.message

      redirect_to "deliverable_type/error"
    end
  end

#This method initializes the static content to be populated in the dropdown lists
  private
  def initialize_for_selects
    begin
      @deliverable_types = RailblazersXmlParser.get_deliverable_type(RailblazersXmlParser.identify_deliverable_type(session[:phase]))
      @deliverable_types << @@ADHOC
      @complexities = RailblazersXmlParser.get_common_values
      @estimated_sizes = RailblazersXmlParser.get_common_values
      @production_rates = RailblazersXmlParser.get_common_values
      @efforts = RailblazersXmlParser.get_common_values

    rescue Exception => ex
      @error_msg = ex.message

      redirect_to "deliverable_type/error"
    end
  end
end
