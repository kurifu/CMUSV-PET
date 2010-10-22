require 'spec_helper'

describe DeliverableTypeController do
  
  #Delete this example and add some real ones
  it "should use DeliverableTypeController" do
    controller.should be_an_instance_of(DeliverableTypeController)
  end

  it "should create a new Deliverable" do
    post 'new'
    response.should render_template("deliverable_type/new")
  end

  it "should redirect to Phase page (deliverables/index) after creating a Deliverable" do
    Deliverable.any_instance.stubs(:valid?).returns(true)
    session[:project_id] = 1
    post 'create'
    assigns[:deliverable].should_not be_new_record
    response.should redirect_to(:controller => "deliverables")
  end

  it "should not redirect to Phase page (deliverables/index) after creating a Deliverable" do
    Deliverable.any_instance.stubs(:valid?).returns(false)
    post 'create'
    assigns[:deliverable].should be_new_record
    response.should render_template("deliverable_type/new")
  end

  it "should pass params to deliverable" do
    post 'create', :deliverable => {:name => "FOO"}
    assigns[:deliverable].name.should == "FOO"
  end

  #Test examples for storycard10
  it "should capture the data in estimated_size field" do
    xhr :post, :capture_calculation_data, :field=>1, :estimated_size=>"32"
    session[:estimated_size].should == "32"
  end

  it "should capture the data in production_rate field" do
    xhr :post, :capture_calculation_data, :field=>2, :production_rate=>"323"
    session[:production_rate].should == "323"
  end

  it "should capture the data in estimated_effort field" do
    xhr :post, :capture_calculation_data, :field=>3, :estimated_effort=>"2"
    session[:estimated_effort].should == "2"
  end

  it "should calculate the estimated_size" do
    session[:production_rate]=3
    session[:estimated_effort]=6
    session[:estimated_size].should be_blank
    xhr :get, :process_calc_inputs
    session[:estimated_size].should == 2
  end

  it "should calculate the production_rate" do
    session[:estimated_size]=3
    session[:estimated_effort]=6
    session[:production_rate].should be_blank
    xhr :get, :process_calc_inputs
    session[:production_rate].should == 2
  end

  it "should calculate the estimated_effort" do
    session[:estimated_size]=8
    session[:production_rate]=4
    session[:estimated_effort].should be_blank
    xhr :get, :process_calc_inputs
    session[:estimated_effort].should == 32
  end
end

