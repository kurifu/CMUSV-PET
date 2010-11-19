require 'spec_helper'

describe DeliverablesController do
  integrate_views
  setup :activate_authlogic
  
  before(:each) do
    @user_session = UserSession.create Factory.build(:valid_user)
    @p = Factory.create(:del_project)
  end

  it "should use DeliverablesController" do
    controller.should be_an_instance_of(DeliverablesController)
  end

  it "should redirect to login page if not logged in" do
    @user_session.destroy
    session[:project_id] = @p.id
    get :index
    response.should redirect_to login_path
  end

  it "should display the Phase page (index) given a project_id" do
    project = mock()
    project.expects(:lifecycle).returns("Simplified Waterfall")
    Project.stubs(:find).returns(project)
    get "index"
    response.should render_template("deliverables/index")
  end

  it "it should populate del table via AJAX when I select a new phase" do
    del = mock()
    del.expects(:project_id).returns(@p.id)
    del.stubs(:phase).returns("Testing")
    puts "PHASE: #{del.phase}"
    session[:project_id] = del.project_id
    xhr :get, :update_deliverable_partial, :phase => del.phase
    assigns[:phase].should_not be_blank
    response.should render_template("_deliverable_partial")
  end

  it "it should NOT populate del table via AJAX when I select a new phase" do
    del = mock()
    del.expects(:project_id).returns(@p.id)
    session[:project_id] = del.project_id
    xhr :get, :update_deliverable_partial
    response.should_not render_template("_deliverable_partial")
    #session[:test_dtypes].should be_nil
  end

  it "should redirect to Add Deliverable Page given a Phase" do

    del = mock()
    del.expects(:phase).returns('Testing')
    session[:phase] = del.phase
    xhr :get, :validate_before_adding_new_type
    flash[:notice].should be_nil
    response.should redirect_to :controller=>"deliverable_type", :action=>"new"
  end

  it "should NOT redirect to Add Deliverable Page without a Phase" do
    xhr :get, :validate_before_adding_new_type
    flash[:notice].should_not be_nil
    response.should redirect_to("deliverables")
  end

  #Testing the case when the default_phase parameter is given
  it "should get data from params[:default_phase] if it is provided" do
    session[:project_id] = @p.id
    get :index, :default_phase=>"Testing"
    #puts params[:default_phase]
    assigns[:deliverable].phase.should == "Testing"

    response.should render_template :index
  end


  describe "Unit of Measurement" do
    before(:each) do
      @deliverable_id ="11"
    end

    it "should provide a unit of measurement given the deliverable type" do
      unit_of_measurement = Array.new
        unit_of_measurement =
          RailblazersXmlParser.get_unit_of_measurement(@deliverable_id)
          for unit in unit_of_measurement do
            puts "UNIT: #{unit}"
          end
        if(@deliverable_id== "11")
          unit_of_measurement.size.should == 3
        else
          unit_of_measurement.size.should == 1
    end
  end
end
end
