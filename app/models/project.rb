require 'rexml/document'
include REXML

class Project < ActiveRecord::Base
  validates_uniqueness_of :name
  validates_presence_of :name, :lifecycle
  has_many :deliverables
  @doc = Document.new File.new("./public/static_table.xml")
  @root = @doc.root
  @LOW = 10
  @MEDIUM = 20
  @HIGH = 30

  def self.get_lifecycle
    lifecycle = Array.new
    counter = 0
    @doc.elements.each("*/lifecycle"){
      |x| lifecycle[counter] = x.attributes["model"].to_s
      counter = counter + 1
    }
    return lifecycle
  end

  def self.get_phase(model)
    phase = Array.new
    temp_phase =
      @root.elements["lifecycle[@model='"+model+"']"].elements["phase"].text
    phase = temp_phase.split(%r{,\s*})
    return phase
  end

  def self.identify_deliverable_type(phase)
    id = case phase
    when "RequirementRequirements Gathering And Analysis" then "1"
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

  def self.get_deliverable_type(id)
    deliverable_type = Array.new
    temp_deliverable_type =
      @root.elements["deliverable_type[@id='"+id+"']"].elements["name"].text
    deliverable_type = temp_deliverable_type.split(%r{,\s*})
    return deliverable_type
  end

  def self.get_unit_of_measurement(id)
    unit = Array.new
    temp_unit =
      @root.elements["deliverable_type[@id='"+id+"']"].elements["unit"].text
    unit = temp_unit.split(%r{,\s*})
    return unit
  end

  def self.get_complexity
    complexity = Array.new
    temp_complexity =
      @root.elements["complexity"].text
    complexity = temp_complexity.split(%r{,\s*})
    return complexity
  end

  def self.get_effort_size(effort)
    effort_size = case effort
      when "Low" then @LOW
      when "Medium" then @MEDIUM
      when "High" then @HIGH
    end
    return effort_size
  end

end
