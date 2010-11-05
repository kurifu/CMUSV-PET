require 'spec_helper'

describe ProjectsHelper do

  #Delete this example and add some real ones or delete this file
  it "should be included in the object returned by #helper" do
    included_modules = (class << helper; self; end).send :included_modules
    included_modules.should include(ProjectsHelper)
  end

  #need to call the helper method through "helper" instance
  it "should calculate effort for each phase" do
    Factory.create :valid_project
    Factory.create :valid_deliverable
    Factory.create :valid_deliverable, :estimated_effort=>32, :production_rate=>4, :estimated_size=>8
    result = helper.calculate_phase_effort(100, "Testing")
    result.should == 44
  end

  it "should return 0 if the dataset is nil" do
    Deliverable.stubs(:find_all_by_phase_and_project_id).returns(nil)
    result = helper.calculate_phase_effort(100, "Testing")
    result.should == 0
  end

end
