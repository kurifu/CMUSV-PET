#Deliverables Controller
class DeliverableTypeController < ApplicationController

  before_filter :initialize_for_selects
  attr_accessor :notice_calc

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
    puts "Captured size: #{params[:estimated_size]}"
    puts "Captured rate: #{params[:production_rate]}"
    puts "Captured effort: #{params[:estimated_effort]}"

    field = params[:field]
    if field == '1'
      session[:estimated_size]=params[:estimated_size]
    elsif field == '2'
      session[:production_rate]=params[:production_rate]
    elsif field == '3'
      session[:estimated_effort]=params[:estimated_effort]
    end

    puts "Current Value: #{session[:estimated_size]}"
    puts "Current Value: #{session[:production_rate]}"
    puts "Current Value: #{session[:estimated_effort]}"
  end

  # Calculate our input data given 2 values and 1 blank
  # TODO:  Refactor this into a more optimal design
  # NOTE:  Small bug with using flash[:notice]! Since we only re-render the partial,
  # =>     The flash[:notice] only shows up in the bottom of the page.
  # =>     However, if you refresh the page after it flashes, it appears at the
  # =>     top as well.  Can we create and flash another variable instead of notice?
  def process_calc_inputs
    
    puts "CHECK Size: #{session[:estimated_size]}"
    puts "CHECK Rate: #{session[:production_rate]}"
    puts "CHECK Effort: #{session[:estimated_effort]}"

    rate = session[:production_rate]
    size = session[:estimated_size]
    effort = session[:estimated_effort]

    # Error: All 3 blank or all 3 filled
    if (effort.blank? && rate.blank? && size.blank?) ||
        (!effort.blank? && !rate.blank? && !size.blank?)
      flash[:notice_calc] = "Please enter two values"
    else
      # Error: Only 1 value
      if effort.blank? && (rate.blank? || size.blank?)
        flash[:notice_calc] = "Please enter two values"
      elsif size.blank? && (effort.blank? || rate.blank?)
        flash[:notice_calc] = "Please enter two values"
      elsif rate.blank? && (effort.blank? || size.blank?)
        flash[:notice_calc] = "Please enter two values"

      # Correct Case: 2 values
      elsif effort.blank? && !rate.blank? && !size.blank?
        puts "* Only effort blank"
        session[:estimated_effort] = rate.to_f * size.to_f
        @notice_calc = ""
      elsif size.blank? && !rate.blank? && !effort.blank?
        puts "* size blank"
        session[:estimated_size] = effort.to_f / rate.to_f
        @notice_calc = ""
      elsif rate.blank? && !effort.blank? && !size.blank?
        puts "* rate blank"
        session[:production_rate] = effort.to_f / size.to_f
        @notice_calc = ""
      else
        puts "ERROR!"
        # TODO:  Raise some kind of exception which we can catch
      end

      puts "Calc'd Size: #{session[:estimated_size]}"
      puts "Calc'd Rate: #{session[:production_rate]}"
      puts "Calc'd Effort: #{session[:estimated_effort]}"
    end

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
