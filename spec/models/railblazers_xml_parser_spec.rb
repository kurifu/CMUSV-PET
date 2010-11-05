# To change this template, choose Tools | Templates
# and open the template in the editor.

require 'spec_helper'

describe RailblazersXmlParser do
  before(:each) do
    @parser = RailblazersXmlParser
    @lifecycles = @parser.get_lifecycle
  end

  it "should retrieve all 3 lifecycles" do
    @lifecycles.size.should == 3
    @lifecycles[0].should == "Simplified WaterFall"
    @lifecycles[1].should == "Spiral"
    @lifecycles[2].should == "Incremental"
  end

  it "should retrieve every phase for a given lifecycle" do
    @phases = @parser.get_phase(@lifecycles[0])
    @phases.size.should == 6
    @phases[0].should == "Requirements Gathering And Analysis"
    @phases[-1].should == "Maintenance"

    # Test the last lifecycle
    @phases = @parser.get_phase(@lifecycles[-1])
    @phases.size.should == 5
    @phases[0].should == "Requirements"
    @phases[-1].should == "Operation"
  end

  it "should retrieve the correct id for a given phase" do
    @parser.identify_deliverable_type("Requirements Gathering And Analysis").should == "1"
    @parser.identify_deliverable_type("System Design").should == "2"
    @parser.identify_deliverable_type("Implementation").should == "3"
    @parser.identify_deliverable_type("Testing").should == "4"
    @parser.identify_deliverable_type("Deployment").should == "5"
    @parser.identify_deliverable_type("Maintenance").should == "6"
    @parser.identify_deliverable_type("Planning").should == "7"
    @parser.identify_deliverable_type("Risk Analysis").should == "8"
    @parser.identify_deliverable_type("Engineering").should == "9"
    @parser.identify_deliverable_type("Evaluation").should == "10"
  end

  it "should retrieve the correct deliverable types given a id" do
    dtypes = @parser.get_deliverable_type("1")
    dtypes[0].should == "Requirement document"
    dtypes[1].should == "Requirement Analysis"

    dtypes = @parser.get_deliverable_type("10")
    dtypes[0].should == "xyz10"
    dtypes[1].should == "abc10"
  end

  it "should retrieve the correct unit of measurement given an id" do
    dtypes = @parser.get_unit_of_measurement("1")
    dtypes.each do |f|
      f.should == "pages"
    end
    dtypes = @parser.get_unit_of_measurement("10")
    dtypes.each do |f|
      f.should == "dummy10"
    end
  end

  it "should return low/med/high values" do
    values = @parser.get_common_values
    values[0].strip.should == "Low"
    values[1].strip.should == "Medium"
    values[2].strip.should == "High"
  end
end

