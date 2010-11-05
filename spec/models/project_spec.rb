require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {
    }
  end


  it "should be valid with valid attributes" do
    project = Factory.build(:valid_project)
    project.should be_valid
  end

  it "should have a non-nil name" do
    projectwithoutname = Factory.build(:valid_project, :name=>nil)
    projectwithoutname.should have(1).error_on(:name)
    # same as projectwithoutname.errors.invalid?(:name).should == true
    projectwithoutname.errors.should be_invalid :name
  end

  it "should have unique name" do
    Factory.create(:valid_project)
    project = Factory.build(:valid_project, :name=>'PET 1.3')
    # same as project.save.should == false
    project.save.should be_false
    project.errors.on(:name).should == "has already been taken"
    
  end

  it "should have non-nil lifecycle" do
    project = Factory.build(:valid_project, :lifecycle=>nil)
    project.valid?.should be_false
    project.errors.invalid?(:lifecycle).should == true
  end
end
