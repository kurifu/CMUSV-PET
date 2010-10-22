# NOTE: .invalid? seems to perform a .save before
#       Error msg only appears if you save to DB
#       .invalid? is equivalent to .save in some sense

require 'spec_helper'

describe Deliverable do
  before(:each) do
    deliverable = Factory.build(:deliverable)
    # the same as deliverable.valid?.should == true
    deliverable.should be_valid
  end

#  it "should create a new instance given valid attributes" do
#    Deliverable.create!(@valid_attributes)
#  end
  it "should have a non-nil phase" do
    deliverable = Factory.build(:deliverable, :phase=>nil)
    deliverable.should be_invalid
    deliverable.should have(1).error_on(:phase)
    deliverable.errors.should be_invalid :phase
  end

  it "should have a non-nil deliverable_type" do
    deliverable = Factory.build(:deliverable, :deliverable_type=>nil)
    deliverable.should be_invalid
    deliverable.should have(1).error_on(:deliverable_type)
    deliverable.errors.should be_invalid :deliverable_type
  end

  it "should have a non-nil project_id" do
    deliverable = Factory.build(:deliverable, :project_id=>nil)
    deliverable.save
    deliverable.should have(2).errors_on(:project_id)
    deliverable.errors.should be_invalid :project_id
  end

  it "should have a non-nil name" do
    deliverable = Factory.build(:deliverable, :name=>nil)
    deliverable.should be_invalid
    deliverable.should have(1).error_on(:name)
    deliverable.errors.should be_invalid :name
  end

#  it "should have a non-nil deliverable_url" do
#    deliverable = Factory.build(:deliverable, :deliverable_url=>nil)
#    assert deliverable.invalid?
#    deliverable.should have(2).error_on(:deliverable_url)
#    assert deliverable.errors.invalid?(:deliverable_url)
#  end

  it "should have a non-nil complexity" do
    deliverable = Factory.build(:deliverable, :complexity=>nil)
    deliverable.save
    deliverable.should have(1).error_on(:complexity)
    deliverable.errors.should be_invalid :complexity
  end

  it "should have a non-nil unit of measurement" do
    deliverable = Factory.build(:deliverable, :unit_measurement=>nil)
    deliverable.save
    deliverable.should have(1).error_on(:unit_measurement)
    deliverable.errors.should be_invalid :unit_measurement
  end
  
  it "should have a numeric estimated size" do
    deliverable = Factory.build(:deliverable, :estimated_size=>"")
    deliverable.save
    deliverable.should have(1).error_on(:estimated_size)
  end

  it "should have a numeric estimated size" do
    deliverable = Factory.build(:deliverable, :estimated_effort=>"")
    deliverable.save
    deliverable.should have(1).error_on(:estimated_effort)
  end

  it "should have a numeric estimated size" do
    deliverable = Factory.build(:deliverable, :production_rate=>nil)
    deliverable.save
    deliverable.should have(1).error_on(:production_rate)
  end

  it "should calculate the result according to the given 2 values"
end
