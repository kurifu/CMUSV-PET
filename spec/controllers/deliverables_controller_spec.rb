require 'spec_helper'

describe DeliverablesController do

  before(:each) do
    # doesn't work for catching errors
    #controller.use_rails_error_handling!
    #Deliverable.stub!(:index).and_raise(ActiveRecord::RecordNotFound)
    #Deliverable.any_instance.stubs(:index).and_raise(ActiveRecord::RecordNotFound)
    #get "index"

    # mocha example, doesn't work..
    #object = mock()
    #object.expects(:index).raises(Exception, 'blah')
    #object.expected_method # => raises exception of class Exception and with message 'message'


    project = Factory.create(:del_project)
    project.should be_valid
  end

  it "should use DeliverablesController" do
    controller.should be_an_instance_of(DeliverablesController)
  end


  # NOTE: Fails if we move the Factory.build to the before(:each) section.... wtf??
  it "should display the Phase page (index) given a project_id" do
    del = Factory.build(:deliverable)
    del.should be_valid
    session[:project_id] = del.project_id
    get "index"
    response.should render_template("deliverables/index")
  end

=begin
  # TODO:  Figure out how to test get "index" fails without a project_id (opposite case as the one above)
  it "should not display the Phase page (index) without a project_id" do
    del = Factory.build(:deliverable)
    del.should be_valid
    session[:project_id] = -1
    get"index"
    response.should be_invalid
    
    #Deliverable.any_instance.stubs(:valid?).returns(false)

    # doesn't work
    #get "index", :id => nil
    #response.response_code.should == 404

    #session[:project_id] = nil
    #get "index"
    #response.should be_invalid
  end
=end

  it "it should populate del table via AJAX when I select a new phase" do
    del = Factory.build(:deliverable)
    del.should_not be_invalid
    session[:project_id] = del.project_id
    xhr :get, :update_deliverable_partial, :phase => del.phase
    response.should render_template("_deliverable_partial")
  end

  it "it should NOT populate del table via AJAX when I select a new phase" do
    del = Factory.build(:deliverable)
    del.should_not be_invalid
    session[:project_id] = del.project_id
    xhr :get, :update_deliverable_partial
    response.should_not render_template("_deliverable_partial")
    session[:test_dtypes].should be_nil
  end

  it "should redirect to Add Deliverable Page given a Phase" do
    del = Factory.build(:deliverable)
    del.should be_valid
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

end

