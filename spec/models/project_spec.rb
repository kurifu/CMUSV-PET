require 'spec_helper'

describe Project do
  before(:each) do
    @valid_attributes = {
      :name=>'PET',
      :description=>'test',
      :lifecycle=>'XP'
    }
  end

  it "should create a new instance given valid attributes" do
    Project.create!(@valid_attributes)
  end

  it "should have no errors" do
    project = Factory.build(:project)
    project.should have(:no).errors_on(:attribute)
  end

  it "should have one error on name" do
    project = Factory.build(:project, :name=>'')
    project.should have(:no).errors_on(:name)
  end
end
