require 'spec_helper'

describe ProjectsController do

  #Delete this example and add some real ones
  it "should use ProjectsController" do
    controller.should be_an_instance_of(ProjectsController)
  end

  it "should display the New page" do
    get 'projects/new'
    response.should be_success
    response.should render_template("projects/new")
  end

  it "should redirect to project Show page" do
    get 'projects/show'
    response.should be_success
    response.should render_template("projects/show")
  end

  it "should "
end
