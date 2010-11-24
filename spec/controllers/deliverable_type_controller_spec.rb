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
    response.should redirect_to login_path
  end

  it "should redirect to login page if not logged in" do
    @user_session.destroy
    get :new
    response.should redirect_to login_path
  end

  describe "GET Add Deliverable Page" do
    it "should show the new deliverable page" do
      session[:phase] = "System Design"
      get 'new'
      response.should render_template("deliverable_type/new")
      response.should have_tag('div.content')
      response.should have_tag('table#pet_table')
      response.should have_tag('div#pet_calc_div')
      response.should have_tag('table#historical_data')
      response.should have_tag('table#historical_data th#min')
      response.should have_tag('table#historical_data th#avg')
      response.should have_tag('table#historical_data th#max')
      response.should have_tag('table#historical_data tr#size')
      response.should have_tag('table#historical_data tr#size td', :count => 4)
      response.should have_tag('table#historical_data tr#rate')
      response.should have_tag('table#historical_data tr#rate td', :count => 4)
      response.should have_tag('table#historical_data tr#effort')
      response.should have_tag('table#historical_data tr#effort td', :count => 4)
      #response.should have_tag('a[href=?]', "#", :text => "Reset")

      # Historical Data link
      response.should have_tag('a[href=?]', "#", :text => "Fetch Historical Data")

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

    it "should redirect to login page if not logged in" do
    @user_session.destroy
    get :new
    response.should redirect_to login_path
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
#    response.should have_tag('a[href=?]', "#", :text => "Historical Data")

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
  
  end

  describe "CREATE a Deliverable Type" do
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
      session[:project_id] = 1
      session[:phase] = "System Design"
      session[:deliverable_type_id] = RailblazersXmlParser.identify_deliverable_type(session[:phase])
      post :create
      assigns[:deliverable].should be_new_record
      response.should render_template("deliverable_type/new")
    end

    it "should redirect to Phase page (deliverables/index) after creating a Deliverable with an Ad-hoc Type" do
      Deliverable.any_instance.stubs(:save).returns(true)
      Deliverable.any_instance.stubs(:deliverable_type).returns("Ad-Hoc Type")

      session[:project_id] = 1
      session[:phase] = "Requirements"
      post :create
      response.should redirect_to(:controller => "deliverables", :default_phase => "Requirements")
    end

    it "should not redirect to Phase page (deliverables/index) after creating a Deliverable with an Ad-hoc Type" do
      Deliverable.any_instance.stubs(:save).returns(false)
      Deliverable.any_instance.stubs(:deliverable_type).returns("Ad-Hoc Type")

      session[:project_id] = 1
      session[:phase] = "System Design"
      session[:deliverable_type_id] = RailblazersXmlParser.identify_deliverable_type(session[:phase])
      post :create
      response.should render_template("deliverable_type/new")
    end
  end

  # Make more specific/refine this later
  describe "GET error page for each method" do
    it "should raise an exception in every method" do
      lambda {DeliverableTypeNew.new}.should raise_error
      lambda {DeliverableTypeNew.create}.should raise_error
      lambda {DeliverableTypeNew.initialize_for_selects}.should raise_error
    end
  end

  it "should allow me to pass values for Ad-Hoc fields" do
    #puts "LOOK NOW!"
    #session[:phase] = "System Design"
    #Deliverable.any_instance.stubs(:valid?).returns(true)
    #params = { :deliverable_type => 'Ad-Hoc Type' }

    #puts "in spec, before post create"
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

  describe "GET Historical Data Template" do
    it "should render historical data template" do
      session[:complexity] = "Low"
      session[:deliverable_type] = "UML"
      session[:phase] = "System Design"
      xhr :get, :update_historical_data
      response.should render_template("_pet_historical")
      flash[:warning].should be_nil
    end

    it "should not render historical data if missing fields" do
      session[:complexity] = ""
      session[:deliverable_type] = "UML"
      session[:phase] = "System Design"
      xhr :get, :update_historical_data
      response.flash.now[:warning].should_not be_nil

      assigns[:historical_data].should_not be_nil
      assigns[:historical_data].should == []

      session[:complexity] = nil
      xhr :get, :update_historical_data
      response.flash.now[:warning].should_not be_nil
      assigns[:historical_data].should_not be_nil
      assigns[:historical_data].should == []

      session[:complexity] = "Low"
      session[:deliverable_type] = ""
      xhr :get, :update_historical_data
      response.flash.now[:warning].should_not be_nil
      assigns[:historical_data].should_not be_nil
      assigns[:historical_data].should == []

      session[:deliverable_type] = nil
      xhr :get, :update_historical_data
      response.flash.now[:warning].should_not be_nil
      assigns[:historical_data].should_not be_nil
      assigns[:historical_data].should == []
    end
  end

  describe "GET Historical Data" do
    it "should get min, avg and max values" do
      p1 = Factory.create(:archived_p1)
      p2 = Factory.create(:archived_p2)
      d1 = Factory.create(:historical_d1)
      d2 = Factory.create(:historical_d2)

      session[:phase] = d1.phase
      session[:complexity] = d1.complexity
      session[:deliverable_type] = d1.deliverable_type
   
      xhr :get, :update_historical_data
      response.should render_template("_pet_historical")

      assigns[:historical_data].should_not be_nil
      assigns[:historical_data][0].should == 1.0
      assigns[:historical_data][1].should == 1.5
      assigns[:historical_data][2].should == 2.0
      assigns[:historical_data][3].should == 3.0
      assigns[:historical_data][4].should == 5.5
      assigns[:historical_data][5].should == 8.0
      assigns[:historical_data][6].should == 6.0
      assigns[:historical_data][7].should == 7.0
      assigns[:historical_data][8].should == 8.0
    end

    it "should get dummy values if it cannot find data" do
      d1 = Factory.create(:historical_d1)

      session[:phase] = d1.phase
      session[:complexity] = "High"#d1.complexity
      session[:deliverable_type] = d1.deliverable_type

      xhr :get, :update_historical_data
      response.should render_template("_pet_historical")

      assigns[:historical_data].should_not be_nil
      assigns[:historical_data][0].should == "?"
      assigns[:historical_data][-1].should == "?"
    end
  end

  describe "Ajax tests" do
    it "should render partial when request latch_deliverable_type" do
      session[:complexity] = "Low"
      session[:phase] = "System Design"
      session[:deliverable_type] = "Ad-Hoc Type"
      xhr :get, :latch_deliverable_type, :deliverable_type=>"Ad-Hoc Type"
      response.should render_template "deliverable_type/_ad_hoc_type"
    end

    it "should render partial when request latch_deliverable_type without an Ad-Hoc Type" do
      session[:complexity] = "Low"
      session[:phase] = "System Design"
      session[:deliverable_type_id] = "3"
      session[:deliverable_type] = "UML"
      xhr :get, :latch_deliverable_type, :deliverable_type=>"UML"
      response.should render_template "deliverable_type/_blank"
    end

    it "should render nothing with Select a deliverable type" do
      session[:complexity] = "Low"
      session[:phase] = "System Design"
      session[:deliverable_type] = "Ad-Hoc Type"
      xhr :get, :latch_deliverable_type, :deliverable_type=>"Select a deliverable type"
      response.body.strip.should be_empty
    end

    it "should render partial when request latch_complexity" do
      session[:complexity] = "Low"
      session[:phase] = "System Design"
      session[:deliverable_type] = "UML"
      xhr :get, :latch_complexity, :complexity=>"UML"
      response.body.strip.should be_empty
    end
  end

end
