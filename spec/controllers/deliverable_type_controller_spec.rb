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

  #Cases for only one field is entered
  it "should not calculate and show flash message on estimated_size" do
    session[:estimated_size]=8
    if (!session[:estimated_size].blank? && session[:production_rate].blank? && session[:estimated_effort].blank?)
      flash[:notice_for_petcalculation].should == "Please enter 2 fields, you only entered estimated size"
    end
  end

  it "should not calculate and show flash message on production_rate" do
    session[:production_rate]=8
    if (session[:estimated_size].blank? && !session[:production_rate].blank? && session[:estimated_effort].blank?)
      flash[:notice_for_petcalculation].should == "Please enter 2 fields, you only entered production rate"
    end
  end

  it "should not calculate and show flash message on estimated_effort" do
    session[:estimated_effort]=8
    if (session[:estimated_size].blank? && session[:production_rate].blank? && !session[:estimated_effort].blank?)
      flash[:notice_for_petcalculation].should == "Please enter 2 fields, you only entered estimated effort"
    end
  end

  it "should be correct if the result of the 3 fields matches" do
    session[:estimated_size]=2
    session[:production_rate]=3
    session[:estimated_effort]=6
    if (!session[:estimated_size].blank? && !session[:production_rate].blank? && !session[:estimated_effort].blank?)
      (session[:estimated_size].to_f * session[:production_rate].to_f).should == session[:estimated_effort].to_f
    end
  end

  it "should be failed if the result of the 3 fields does not match" do
    session[:estimated_size]=2
    session[:production_rate]=3
    session[:estimated_effort]=7
    if (!session[:estimated_size].blank? && !session[:production_rate].blank? && !session[:estimated_effort].blank?)
      unless (session[:estimated_size].to_f * session[:production_rate].to_f) == session[:estimated_effort].to_f
        flash[:notice_for_petcalculation].should == "All fields are entered, but the result is incorrect"
      end
    end
  end
end

