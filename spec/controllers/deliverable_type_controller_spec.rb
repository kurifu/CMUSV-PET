require 'spec_helper'

describe DeliverableTypeController do
  before(:each) do
    del_item = Factory.build(:deliverable)
    del_item.should be_valid
  end
  
  #Delete this example and add some real ones
  it "should use DeliverableTypeController" do
    controller.should be_an_instance_of(DeliverableTypeController)
  end

  # Tests for storycard15
  it "should create a new Deliverable" do
    post 'new'
    response.should render_template("deliverable_type/new")
  end

  it "should redirect to Phase page (deliverables/index) after creating a Deliverable" do
    Deliverable.any_instance.stubs(:create).returns(true)
    session[:project_id] = 1
    #post 'create'
    #assigns[:deliverable].should_not be_new_record
    response.should redirect_to(:controller => "deliverables")
  end

  it "should not redirect to Phase page (deliverables/index) after creating a Deliverable" do
    Deliverable.any_instance.stubs(:create).returns(false)
    post 'create'
    assigns[:deliverable].should be_new_record
    response.should render_template("deliverable_type/new")
  end

  it "should pass params to deliverable" do
    post 'create', :deliverable => {:name => "FOO"}
    assigns[:deliverable].name.should == "FOO"
  end

end

