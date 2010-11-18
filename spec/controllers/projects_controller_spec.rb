require 'spec_helper'

describe ProjectsController do
  setup :activate_authlogic
  integrate_views
  
  before(:each) do
    @user_session = UserSession.create Factory.build(:valid_user)
  end

  it "should redirect to login page if not logged in" do
    @user_session.destroy
    get :new
    response.should redirect_to login_path
  end

  describe "DUMMY Testing" do
    it "should use ProjectsController" do
      controller.should be_an_instance_of(ProjectsController)
    end

    it "should pass params to project" do
      post 'create', :project => {:name => "BLAH"}
      assigns[:project].name.should == "BLAH"
    end
  end

  describe "GET New deliverable page" do
    it "should display the New page" do
      get :new
      response.should render_template("projects/new")
    end
  end

  describe "POST Create deliverable" do
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
  end

  # Project Overview Testing
  describe "GET Overview" do
    it "should render the overview screen" do
      
=begin
      project_item = mock()
      project_item.stubs(:valid?).returns(true)
      project_item.expects(:name).returns("Name Here?")
      project_item.expects(:lifecycle).returns("Simplified WaterFall")

      fake_del1 = mock()
      fake_del1.expects(:phase).returns("System Design")
      fake_del1.expects(:name).returns("Fake1")
      fake_del2 = mock()
      fake_del2.expects(:phase).returns("Implementation")
      fake_del2.expects(:name).returns("Fake2")
      
=end
      p1 = Factory.create(:archived_p1)
      d1 = Factory.create(:historical_d1)
      fake_del_array = [d1]


      #To stub class methods, just call stubs on the model class
      Project.stubs(:find_by_id).returns(p1)
      Deliverable.stubs(:find_all_by_project_id).returns(fake_del_array)

      get :overview
      response.should render_template("projects/overview")
    end
  end

  describe "GET Error Pages" do
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

  describe "GET Project home/show page" do
    it "should get the project show page" do

      fakeproject = mock()
      Project.stubs(:find).returns(fakeproject)
      fakeproject.expects(:name).returns("project name")
      fakeproject.expects(:lifecycle).returns("lifecycle")
      fakeproject.expects(:description).returns("description here")

      get :show, :id => fakeproject.id
      response.should render_template("projects/show")
      response.should have_tag("table#content_overview")
    end

    it "should display all deliverables" do
      d1 = Factory.create(:historical_d1)
      p1 = Factory.create(:archived_p1)

      dels = [d1]
      Deliverable.stubs(:find).returns(dels)
=begin
      fakeproject = mock()
      fakeproject.expects(:id).returns(d1.project_id)
      fakeproject.expects(:name).returns("project name")
      fakeproject.expects(:lifecycle).returns("lifecycle")
      fakeproject.expects(:description).returns("description here")
=end
      
      get :show, :id => p1.id
      response.should render_template("projects/show")
      # TODO: figure out assigns, test sort order!
    end
  end

  it "should log effort for each deliverable" do
    p1 = Factory.create(:archived_p1)
    d1 = Factory.create(:historical_d1)
    d1.hours_logged.should == 0.0
    get :log_hours, :project_id => p1.id, :deliverable_id => d1.id, :hours_logged => 3.0
    response.should render_template('projects/show')
    assigns[:target_del].hours_logged.should == 3.0
  end
end
