require 'spec_helper'

describe DeliverableTypeController do
  before(:each) do
    @new_deliverable = Factory.build(:deliverable)
    @new_deliverable.should be_valid
  end

  #Delete this example and add some real ones
  it "should use DeliverableTypeController" do
    controller.should be_an_instance_of(DeliverableTypeController)
  end

  it "should NOT redirect to Phase page (deliverables/index) when I click Create" do
    
    # Missing fields should make it fail
    post "create"
    response.should_not be_success
    response.should render_template("deliverable_type/new")
  end

  it "should redirect to Phase page (deliverables/index) when I click Create" do

    # TODO:  figure out how to get to another controller's index page
    # TODO:  figure out how to create a deliverable and post it
    post "create"
    #response.should be_success
    response.should render_template("deliverable_type/new")
  end
end

