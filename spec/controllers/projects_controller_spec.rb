require 'spec_helper'

describe ProjectsController do
  setup :activate_authlogic
  
  before(:each) do
    @user_session = UserSession.create Factory.build(:valid_user)
  end

  it "should redirect to login page if not logged in" do
    @user_session.destroy
    get :new
    response.should redirect_to login_path
  end

  it "should use ProjectsController" do
    controller.should be_an_instance_of(ProjectsController)
  end

  it "should pass params to project" do
    post 'create', :project => {:name => "BLAH"}
    assigns[:project].name.should == "BLAH"
  end

  it "should display the New page" do
    get :new
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
    project_item = mock()
    project_item.expects(:lifecycle).returns("Simplified WaterFall")

    #To stub class methods, just call stubs on the model class
    Project.stubs(:find_by_id).returns(project_item)
    get :overview
    response.should render_template("projects/overview")
  end

  it "should display error page if it cannot find the project" do
    Project.stubs(:find_by_id).raises(Exception, 'A stubed exception')
    get :overview
    response.should redirect_to "/500.html"
  end

  it "should render the correct page when an exception is raised" do
    Project.stubs(:find_by_id).raises(Exception, 'A stubed exception')
    get :overview
    response.should redirect_to "/500.html"

  end

  it "should go to 500 with weird exception" do
    Project.stubs(:all).raises(Exception, 'A stubed exception')
    get :index
    response.should redirect_to "/500.html"
  end
end
