require 'spec_helper'

describe DeliverableTypeController do

  integrate_views

  before(:each) do
    del_item = Factory.build(:deliverable)
    del_item.should be_valid
  end
  
  #Delete this example and add some real ones
  it "should use DeliverableTypeController" do
    controller.should be_an_instance_of(DeliverableTypeController)
  end

  # Tests for storycard15
  it "should get the new page" do
    get 'new'
    response.should render_template("deliverable_type/new")
    response.should have_tag ('div.content#new_del')
    response.should have_tag('table#pet_table')
    response.should have_tag('div.content#new_del')
    response.should have_tag('table#pet_table')
    response.should have_tag('div#pet_calc_div')
    #response.should have_tag('a[href=?]', "#", :text => "Calculate")
    #response.should have_tag('a[href=?]', "#", :text => "Reset")
    
    # Historical Data link
    response.should have_tag('a[href=?]', "#", :text => "Historical Data")
    response.should have_tag "form[action=/deliverable_type/create]" do
      with_tag "select[name='deliverable[deliverable_type]']"
      with_tag "input[type=text][name='deliverable[name]']"
      with_tag "textarea[name='deliverable[description]']"
      with_tag "select[name='deliverable[complexity]']"
      with_tag "input[type=text][name='deliverable[unit_measurement]']"
      with_tag "input[type=text][name='deliverable[estimated_size]']"
      with_tag "input[type=text][name='deliverable[production_rate]']"
      with_tag "input[type=text][name='deliverable[estimated_effort]']"
      with_tag "input[type=submit][name='commit'][id=deliverable_submit]"
    end
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

end

