require 'spec_helper'

describe DeliverableTypeController do
  
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

  # Tests for storycard10
  # Testing the process_calc_inputs method
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

  # Testing the process_calc_inputs method
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

  # Cases for when only one field is entered
  # NOTE:  Very DRY right now...  is there a better solution?
  it "should not calculate with only 1 field and show the appropriate flash message" do
    session[:estimated_size] = 8
    xhr :get, :process_calc_inputs
    flash[:notice_calc].should == "Please enter two values"

    session[:estimated_size] = ""
    session[:production_rate] = 8
    xhr :get, :process_calc_inputs
    flash[:notice_calc].should == "Please enter two values"

    session[:production_rate] = ""
    session[:estimated_effort] = 8
    xhr :get, :process_calc_inputs
    flash[:notice_calc].should == "Please enter two values"

    # Verify that the flash notice disappears when we satisfy the method
    session[:production_rate] = 1
    xhr :get, :process_calc_inputs
    flash[:notice_calc].should be_nil
  end

  # NOTE:  We need to discuss this; are we going to let the user supply
  #        all 3 values?  Or just two?
  # This is not testing anything; we aren't calling any methods
  it "should be correct if the result of the 3 fields matches" do
    session[:estimated_size]=2
    session[:production_rate]=3
    session[:estimated_effort]=6
    if (!session[:estimated_size].blank? && !session[:production_rate].blank? && !session[:estimated_effort].blank?)
      (session[:estimated_size].to_f * session[:production_rate].to_f).should == session[:estimated_effort].to_f
    end
  end

  # This is not testing anything either, where do you call the method?
  # This is testing if Ruby can perform multiplication with *...
=begin
  it "should fail if the result of the 3 fields does not match" do
    session[:estimated_size]=2
    session[:production_rate]=3
    session[:estimated_effort]=7
    if (!session[:estimated_size].blank? && !session[:production_rate].blank? && !session[:estimated_effort].blank?)
      unless (session[:estimated_size].to_f * session[:production_rate].to_f) == session[:estimated_effort].to_f
        flash[:notice_calc].should == "All fields are entered, but the result is incorrect"
      end
    end
  end
=end
end

