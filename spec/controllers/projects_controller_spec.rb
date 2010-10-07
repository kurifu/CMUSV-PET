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

  it "should stay on New page because fields are empty" do
    post 'create'
    response.should be_success
    response.should render_template("projects/new")
  end

  it "should redirect to Project index page after creating" do

    # TODO:  figure out how to create a project and post it
    post 'create'
    response.should be_success
    response.should render_template("projects/new")
  end
end
