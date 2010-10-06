require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {
    }
  end


  it "should have no errors" do
    project = Factory.build(:project)
    project.should have(:no).errors_on(:name)
  end

  it "should have a non-nil name" do
    projectwithoutname = Factory.build(:testproject)
    projectwithoutname.should have(1).error_on(:name)
    projectwithoutname.errors.invalid?(:name).should == true
  end

  it "should have unique name" do
    Factory.create(:project_existed)
    project = Factory.build(:project, :name=>'rails project')
    project.save.should == false
    project.errors.on(:name).should == "has already been taken"
    
  end

  it "should have non-nil lifecycle" do
    project = Factory.build(:pet_project)
    project.valid?.should == false
    project.errors.invalid?(:lifecycle).should == true
  end
end
