#Deliverables Controller
class DeliverableTypeController < ApplicationController

  @@ADHOC = "Ad-Hoc Type"

  before_filter :initialize_for_selects
  attr_accessor :notice_calc

#The method #new creates a new instance of Deliverable and binds the @deliverable variable 
#with the form element in the new.html.erb file

  def new
  #  begin
      @deliverable = Deliverable.new
      @unit_measurements = []
      respond_to do |format|
        format.html
      end
      
#      rescue Exception => ex
#      @error_msg = ex.message
#
#      redirect_to "deliverable_type/error"
#    end
  end

#Fetches user input from new.html.erb and saves the data on the database
  def create
    puts "create start"
   # begin
      puts "create start, inside exception begin"
      @deliverable = Deliverable.new(params[:deliverable])

      puts "before adhoc stuff"
      if @deliverable.deliverable_type == @@ADHOC
        @deliverable.ad_hoc = true
        @deliverable.deliverable_type = params[:ad_hoc_type]
        @deliverable.unit_measurement = params[:ad_hoc_unit]
      else
        @deliverable.ad_hoc = false
      end

      puts "after adhoc stuff"
      @deliverable.phase = session[:phase]
      @deliverable.project_id = session[:project_id]

      #Code containing entered information when create fails they will be used in the view
      @estimated_size = @deliverable.estimated_size || '' 
      @production_rate = @deliverable.production_rate || '' 
      @estimated_effort = @deliverable.estimated_effort || '' 

      puts "CHECK: #{@deliverable.ad_hoc}"
      puts "#{@deliverable.complexity}"
      puts "#{@deliverable.deliverable_type}"
      puts "#{@deliverable.unit_measurement}"

      puts "before redirect"
      respond_to do |format|
        if @deliverable.save
          puts "good save"
          format.html{ redirect_to :controller => "deliverables", :default_phase=>session[:phase] }
        else
          puts "bad save"
          #set up @unit_of_measurements for fail cases
          @unit_measurements = RailblazersXmlParser.
              get_unit_of_measurement(session[:deliverable_type_id])
          format.html{ render :action => "new", :status => :unprocessable_entity}
        end
      end
      
#      rescue Exception => ex
#      @error_msg = ex.message
#      redirect_to "deliverable_type/error"
#    end
  end

#Update the unit of measurement, depends on what deliverable type is chosen
  def update_unit_of_measurement_partial
    if params[:deliverable_type] == "Ad-Hoc Type"
      render :update do |page|
        page.replace_html 'ad_hoc_type', :partial => 'ad_hoc_type'
        page.replace_html 'ad_hoc_label', :text => "Ad-Hoc Type Name"
        page.replace_html 'unit_of_measurement', :partial => 'ad_hoc_unit'
      end
      return
    else
      
      deliverable_type_id = session[:deliverable_type_id]
      @unit_measurements = RailblazersXmlParser.
      get_unit_of_measurement(deliverable_type_id)
      #puts "Check #{@unit_measurements}"
      render :update do |page|
        page.replace_html 'ad_hoc_type', :partial => 'blank'
        page.replace_html 'ad_hoc_label', :partial => 'blank'
        page.replace_html 'unit_of_measurement',
          :partial => 'unit_of_measurement',
          :object => @unit_measurements
      end
    end
  end
#This method initializes the static content to be populated in the dropdown lists
  private
  def initialize_for_selects
  #  begin
      @deliverable_types = RailblazersXmlParser.get_deliverable_type(RailblazersXmlParser.identify_deliverable_type(session[:phase]))
      @deliverable_types << @@ADHOC
      @complexities = RailblazersXmlParser.get_common_values
      @estimated_sizes = RailblazersXmlParser.get_common_values
      @production_rates = RailblazersXmlParser.get_common_values
      @efforts = RailblazersXmlParser.get_common_values

#    rescue Exception => ex
#      @error_msg = ex.message
#
#      redirect_to "deliverable_type/error"
#    end
  end
end
