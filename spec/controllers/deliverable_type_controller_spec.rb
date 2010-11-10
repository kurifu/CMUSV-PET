require 'spec_helper'

describe DeliverableTypeController do

  integrate_views
  setup :activate_authlogic

  before(:each) do
    @user_session = UserSession.create Factory.build(:valid_user)
  end
  
  #Delete this example and add some real ones
  it "should use DeliverableTypeController" do
    controller.should be_an_instance_of(DeliverableTypeController)
  end

  it "should redirect to login page if not logged in" do
    @user_session.destroy
    get :new
    response.should redirect_to root_url
  end

  it "should show the new deliverable page" do
    # Random phase name, doesn't matter what
    session[:phase] = "System Design"
    get 'new'
    response.should render_template("deliverable_type/new")
    response.should have_tag('div.content')
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
      with_tag "select[name='deliverable[unit_measurement]']"
      with_tag "input[type=text][name='deliverable[estimated_size]']"
      with_tag "input[type=text][name='deliverable[production_rate]']"
      with_tag "input[type=text][name='deliverable[estimated_effort]']"
      with_tag "input[type=submit][name='commit'][id=deliverable_submit]"
    end
  end

  it "should redirect to Phase page (deliverables/index) after creating a Deliverable" do
    Deliverable.any_instance.stubs(:valid?).returns(true)
    session[:project_id] = 1
    session[:phase] = "Requirements"
    post 'create'
    assigns[:deliverable].should_not be_new_record
    response.should redirect_to(:controller => "deliverables", :default_phase => "Requirements")
  end

  it "should not redirect to Phase page (deliverables/index) after creating a Deliverable" do
    Deliverable.any_instance.stubs(:valid?).returns(false)
    #del = mock()
    #del.expects(:phase).returns("Requirements")
    #del.expects(:project_id).returns(1)
    #del.expects(:deliverable_type_id).returns(1)
    session[:project_id] = 1
    session[:phase] = "System Design"
    session[:deliverable_type_id] = RailblazersXmlParser.identify_deliverable_type(session[:phase])
    post 'create'
    assigns[:deliverable].should be_new_record
    response.should render_template("deliverable_type/new")
  end

  it "should submit perform a Javascript call when I click 'Calculate" do
  end

  # Make more specific/refine this later
  it "should raise an exception in every method" do
    lambda {DeliverableTypeNew.new}.should raise_error
    lambda {DeliverableTypeNew.create}.should raise_error
    lambda {DeliverableTypeNew.initialize_for_selects}.should raise_error
  end

  it "should allow me to pass values for Ad-Hoc fields" do
    puts "LOOK NOW!"
    #session[:phase] = "System Design"
    Deliverable.any_instance.stubs(:valid?).returns(true)
    #params = { :deliverable_type => 'Ad-Hoc Type' }

    puts "in spec, before post create"
    #post 'create'#, :deliverable => params
    #response.should redirect_to("deliverables")

    #assigns[:deliverable].should_not be_new_record
    #assigns[:deliverable].ad_hoc_type.should == params[:ad_hoc_type]
    #assigns[:deliverable].deliverable_type.should == params[:deliverable_type]
  end

  # Railscast test, doesn't work anymore
  #it "should pass params to deliverable" do
  #  post 'create', :deliverable => {:name => "FOO"}
  #  params[:deliverable].name.should == "FOO"
  #end
  
end

