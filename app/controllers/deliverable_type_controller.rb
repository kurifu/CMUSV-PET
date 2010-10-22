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
  # TODO:  Catch exception cases, like when we try to calculate
  # =>     on 1 value or 3 values
  def process_calc_inputs
    puts "CHECK Size: #{session[:estimated_size]}"
    puts "CHECK Rate: #{session[:production_rate]}"
    puts "CHECK Effort: #{session[:estimated_effort]}"

    rate = session[:production_rate]
    size = session[:estimated_size]
    effort = session[:estimated_effort]

    if effort.blank?
      puts "* effort blank"
      session[:estimated_effort] = rate.to_f * size.to_f
    elsif size.blank?
      puts "* size blank"
      session[:estimated_size] = effort.to_f / rate.to_f
    elsif rate.blank?
      puts "* rate blank"
      session[:production_rate] = effort.to_f / size.to_f
    else
      puts "ERROR!"
      # TODO:  Raise some kind of exception which we can catch
    end

    puts "Calc'd Size: #{session[:estimated_size]}"
    puts "Calc'd Rate: #{session[:production_rate]}"
    puts "Calc'd Effort: #{session[:estimated_effort]}"

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
