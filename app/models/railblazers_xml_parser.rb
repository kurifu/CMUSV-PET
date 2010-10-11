require 'rexml/document'
include REXML

#This class contains all the methods to fetch data from the static database 
#and populate the corresponding dropdown lists

class RailblazersXmlParser
  def initialize
    
  end

  @doc = Document.new File.new("./public/static_table.xml")
  @root = @doc.root
  @LOW = 10
  @MEDIUM = 20
  @HIGH = 30

#This method provides a list of lifecycle
#Input : None
#Output: string array => lifecycle models
  def self.get_lifecycle
    lifecycle = Array.new
    counter = 0
    @doc.elements.each("*/lifecycle"){
      |x| lifecycle[counter] = x.attributes["model"].to_s
      counter = counter + 1
    }
    return lifecycle
  end

#This method provides a list of lifecycle phases
#Input : string => lifecycle model
#Output: string array => lifecycle phases
  def self.get_phase(model)
    phase = Array.new
    temp_phase =
      @root.elements["lifecycle[@model='"+model+"']"].elements["phase"].text
    phase = temp_phase.split(%r{,\s*})
    return phase
  end

#This is an internal method used to populate deliverable types for each phase.
#The method takes in phase as input and outputs an id which can be fed into
# #self.get_deliverable_type method to get appropriate deliverable type
#Input : string => phase
#Output: string => id
  def self.identify_deliverable_type(phase)
    id = case phase
    when "Requirements Gathering And Analysis" then "1"
    when "System Design" then "2"
    when "Implementation" then "3"
    when "Testing" then "4"
    when "Deployment" then "5"
    when "Maintenance" then "6"
    when "Plannig" then "7"
    when "Risk Analysis" then "8"
    when "Engineering" then "9"
    when "Evaluation" then "10"
    when "Requirements" then "1"
    when "Implementation And Unit Testing" then "3"
    when "Integration And System Testing" then "4"
    when "Operation" then "5"
    end
    return id
  end

#This method takes the return value of #self.identify_deliverable_type
#as input and provides a list of deliverable types as output 
#Input : string => return value of #self.identify_deliverable_type
#Output: string array => deliverable types
  def self.get_deliverable_type(id)
    deliverable_type = Array.new
    temp_deliverable_type =
      @root.elements["deliverable_type[@id='"+id+"']"].elements["name"].text
    deliverable_type = temp_deliverable_type.split(%r{,\s*})
    return deliverable_type
  end

#This method takes the return value of #self.identify_deliverable_type
#as input and provides a list of unit of measurements as output 
#Input : string => return value of #self.identify_deliverable_type
#Output: string array => unit of measurement
  def self.get_unit_of_measurement(id)
    unit = Array.new
    temp_unit =
      @root.elements["deliverable_type[@id='"+id+"']"].elements["unit"].text
    unit = temp_unit.split(%r{,\s*})
    return unit
  end

  def self.get_common_values
    common_values = Array.new
    temp_complexity =
      @root.elements["complexity"].text
    common_values = temp_complexity.split(%r{,\s*})
    return common_values
  end

 
  def self.get_estimated_size(effort)
    estimated_size = case effort
      when "Low" then @LOW
      when "Medium" then @MEDIUM
      when "High" then @HIGH
    end
    return estimated_size
  end
end
