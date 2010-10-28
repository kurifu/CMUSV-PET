require 'spec_helper'

describe ProjectsController do

  # Not needed it seems... 
  #before(:each) do
  #  project_item = Factory.build(:project)
    # the same as deliverable.valid?.should == true
  #  project_item.should be_valid
  #end

  it "should use ProjectsController" do
    controller.should be_an_instance_of(ProjectsController)
  end

  it "should pass params to project" do
    post 'create', :project => {:name => "BLAH"}
    assigns[:project].name.should == "BLAH"
  end

  it "should display the New page" do
    get 'projects/new'
    response.should be_success
    response.should render_template("projects/new")
  end

  it "should redirect to Project index page after creating a Project" do
    Project.any_instance.stubs(:valid?).returns(true)
    post 'create'

    # if save succeeds, it should not be a new record
    assigns[:project].should_not be_new_record
    response.should redirect_to("deliverables")
    #flash[:notice].should be_nil no way of telling; flash gone when we jump controllers
  end

  it "should stay on New page because fields are empty" do
    Project.any_instance.stubs(:valid?).returns(false)
    post 'create'

    # if save fails, it should be a new record
    assigns[:project].should be_new_record
    response.should render_template("projects/new")
    
    # Book example, doesnt seem to work
    #temp = double('project')
    #temp.should_receive(:create).and_return(true)
    #post 'create'
  end

  # Project Overview Testing
  it "should render the overview screen" do
    project_item = Factory.build(:del_project)
    project_item.should be_valid
    session[:project_id] = project_item.id
    get :overview
    response.should render_template("projects/overview")
    session[:project_id].should_not be_nil
    
  end
end
