#Deliverables Controller
class DeliverableTypeController < ApplicationController
before_filter :require_user
  #Constant variable for the option in the select tag
  @@ADHOC = "Ad-Hoc Type"
  
  before_filter :initialize_for_selects
  attr_accessor :notice_calc

#The method #new creates a new instance of Deliverable and binds the @deliverable variable 
#with the form element in the new.html.erb file
  def new
    @deliverable = Deliverable.new
    @unit_measurements = []

    # These are needed to render historical data
    @historical_data = []
    session[:deliverable_type] = nil
    session[:complexity] = nil
    
    respond_to do |format|
      format.html
    end
  end

#Fetches user input from new.html.erb and saves the data on the database.
#Before it save data into database it will check whether the deliverable_type
#is ad-hoc type or not. If it is it will get the data and unit of measurement
#of the ad-hoc type.
  def create
    @deliverable = Deliverable.new(params[:deliverable])
    @historical_data = []

    if @deliverable.deliverable_type == @@ADHOC
      @deliverable.ad_hoc = true
      @deliverable.deliverable_type = params[:ad_hoc_type]
      @deliverable.unit_measurement = params[:ad_hoc_unit]
    else
      @deliverable.ad_hoc = false
    end

    @deliverable.phase = session[:phase]
    @deliverable.project_id = session[:project_id]

    respond_to do |format|
      if @deliverable.save
        format.html{ redirect_to :controller => "deliverables", :default_phase=>session[:phase] }
      else
        #set up ad-hoc values for fail cases
        if true == @deliverable.ad_hoc
          @ad_hoc_type = @deliverable.deliverable_type
          @ad_hoc_measurement = @deliverable.unit_measurement
          #set up ad-hoc type for fail cases
          @deliverable.deliverable_type = @@ADHOC
        end

        #Code containing entered information when create fails they will be used in the view
        @estimated_size = @deliverable.estimated_size || ''
        @production_rate = @deliverable.production_rate || ''
        @estimated_effort = @deliverable.estimated_effort || ''

        #set up @unit_of_measurements for fail cases
        @unit_measurements = RailblazersXmlParser.
            get_unit_of_measurement(session[:deliverable_type_id])

        format.html{ render :action => "new", :status => :unprocessable_entity}
      end
    end
  end

#Latch onto deliverable type; this is called when deliverable type is changed
#Also renders unit of measurement
  def latch_deliverable_type
    unless params[:deliverable_type] == "Select a deliverable type"
      puts "\tgot a deliverable type"
      session[:deliverable_type] = params[:deliverable_type]
      render_measurement
      return
    end
    render :nothing => true
  end

#Latch onto complexity; this is called when complexity is changed
  def latch_complexity
    unless params[:complexity] == "Select a complexity"
      puts "\tgot a complexity"
      session[:complexity] = params[:complexity]
    end
    render :nothing => true
  end

#Updates unit of measurement field, only called when deliverable type changes
  def render_measurement
    # If we have ad-hoc type
    if session[:deliverable_type] == "Ad-Hoc Type"
      render :update do |page|
        page.replace_html 'ad_hoc_type', :partial => 'ad_hoc_type'
        page.replace_html 'ad_hoc_label', :text => "Ad-Hoc Type Name"
        page.replace_html 'unit_of_measurement', :partial => 'ad_hoc_unit'
      end
      return
    # Not ad-hoc
    else
      deliverable_type_id = session[:deliverable_type_id]
      @unit_measurements = RailblazersXmlParser.
        get_unit_of_measurement(deliverable_type_id)
      
      render :update do |page|
        page.replace_html 'ad_hoc_type', :partial => 'blank'
        page.replace_html 'ad_hoc_label', :partial => 'blank'
        page.replace_html 'unit_of_measurement',
          :partial => 'unit_of_measurement',
          :object => @unit_measurements
      end
    end
  end

#Update the historical data, depends on the deliverable type and complexity
  def update_historical_data
    #puts "start of update_historical_data"
    @historical_data = []

    # Render stuff
    unless session[:complexity].nil? || session[:deliverable_type].nil? || session[:complexity].blank? || session[:deliverable_type].blank?
      # TODO: Calculate/Gather data

      #puts "before calculate_historical_data"
      @historical_data = calculate_historical_data

      #session[:test_histdata]
      #puts "before render pet_historical"
      render(:partial => 'pet_historical',
        :layout => false,
        :object => @historical_data)
    else
      #puts "before flash warning and render historical"
      flash.now[:warning] = "Please select a deliverable type and complexity"
      render(:partial => 'pet_historical',
        :layout => false,
        :object => @historical_data)
      #render :nothing => true
    end
  end

  def calculate_historical_data

    data = []
    collector = []

    target_projects = Project.find(:all, :conditions => ['status = ?', 'archived'])
    #puts "NUMBER OF PROJECTS: #{target_projects.size}"
    #puts "NUMBER OF DELIVERABLES: #{collector.size}"
    target_projects.each do |p|
      #puts "* ID: #{p.id}"
      
      # Note: do not use <<, as find:all returns an array, we would be appending
      # the whole array as a single entry
      d = Deliverable.find(:all, :conditions => ['complexity = ? AND deliverable_type = ? AND project_id = ?', session[:complexity], session[:deliverable_type], p.id])
      #puts "found '#{d}', size is '#{d.size}'"
      collector = collector | d
    end
    #puts "NUMBER OF DELIVERABLES: #{collector.size}"

    sizes = []
    efforts = []
    rates = []

=begin
    puts "CHECK: '#{collector}'"
    if collector.empty?
      puts "collector is empty"
    end

    if collector.blank?
      puts "collector is blank"
    end
=end
    
    unless collector.empty? || collector.blank?
      #puts "found stuff in collector"
      collector.each do |c|
        #puts "c is '#{c}'"
        sizes << c.estimated_size
        efforts << c.estimated_effort
        rates << c.production_rate
      end

      data[0] = sizes.min
      data[1] = (sizes.size == 0) ? "-" : sizes.sum / sizes.size
      data[2] = sizes.max

      data[3] = rates.min
      data[4] = (rates.size == 0) ? "-" : rates.sum / rates.size
      data[5] = rates.max

      data[6] = efforts.min
      data[7] = (efforts.size == 0) ? "-" : efforts.sum / efforts.size
      data[8] = efforts.max

    else
      #puts "didn't find anything"
      data.fill("-", 0, 9)
    end

    return data
  end

  private
  #This method initializes the static content to be populated in the dropdown lists
  def initialize_for_selects
      @deliverable_types = RailblazersXmlParser.get_deliverable_type(RailblazersXmlParser.identify_deliverable_type(session[:phase]))
      @deliverable_types << @@ADHOC
      @complexities = RailblazersXmlParser.get_common_values
      @estimated_sizes = RailblazersXmlParser.get_common_values
      @production_rates = RailblazersXmlParser.get_common_values
      @efforts = RailblazersXmlParser.get_common_values
  end
end
