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
    assert projectwithoutname.errors.invalid?(:name)
  end

  it "should have unique name" do
    Factory.create(:project_existed)
    project = Factory.build(:project, :name=>'rails project')
    assert !project.save
    assert_equal "has already been taken", project.errors.on(:name)
    
  end

  it "should have lifecycle" do
    project = Factory.build(:pet_project)
    assert !project.valid?
    assert project.errors.invalid?(:lifecycle)
  end
end
