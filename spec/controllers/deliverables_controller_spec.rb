require 'spec_helper'

describe DeliverablesController do
integrate_views
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

  describe "GET deliverables/index phase page" do
    # NOTE: Fails if we move the Factory.build to the before(:each) section.... wtf??
    it "should display the Phase page (index) given a project_id" do
      del = mock()
      del.expects(:project_id).returns(100)
      session[:project_id] = del.project_id
      get "index"
      response.should render_template("deliverables/index")
    end

    it "it should populate del table via AJAX when I select a new phase" do
      del = mock()
      del.expects(:project_id).returns(100)
      del.expects(:phase).returns('Testing')
      session[:project_id] = del.project_id
      xhr :get, :update_deliverable_partial, :phase => del.phase
      response.should render_template("_deliverable_partial")
    end

    it "it should NOT populate del table via AJAX when I select a new phase" do
      del = mock()
      del.expects(:project_id).returns(100)
      session[:project_id] = del.project_id
      xhr :get, :update_deliverable_partial
      response.should_not render_template("_deliverable_partial")
      #session[:test_dtypes].should be_nil
    end
  end

  describe "GET redirect to Add Deliverable Type" do
    it "should redirect to Add Deliverable Page given a Phase" do
      del = mock()
      del.expects(:phase).returns('Testing')
      session[:phase] = del.phase
      xhr :get, :validate_before_adding_new_type
      flash[:notice].should be_nil
      response.should redirect_to :controller => :deliverable_type,
        :action => :new
    end

    it "should NOT redirect to Add Deliverable Page without a Phase" do
      xhr :get, :validate_before_adding_new_type
      flash[:notice].should_not be_nil
      response.should redirect_to :controller => :deliverables
    end
  end

  describe "GET index with default phase" do
    #Testing the case when the default_phase parameter is given
    it "should get data from params[:default_phase] if it is provided" do
      session[:project_id]=100
      get :index, :default_phase=>"Testing"
      assigns[:deliverable].phase.should == "Testing"
      response.should render_template :index
    end
  end


  describe "GET Unit of Measurement" do
    before(:each) do
      @deliverable_id ="11"
    end
    it "should provide a unit of measurement given the deliverable type" do
      unit_of_measurement = Array.new
        unit_of_measurement =
          RailblazersXmlParser.get_unit_of_measurement(@deliverable_id)
          #for unit in unit_of_measurement do
            #puts "UNIT: #{unit}"
          #end
        if(@deliverable_id== "11")
          unit_of_measurement.size.should == 3
        else
          unit_of_measurement.size.should == 1
      end
    end
  end

  describe "GET upload attachment page" do
    before(:each) do
      @p1 = Factory.create(:archived_p1)
      @d1 = Factory.create(:historical_d1)
    end

    it "should display add_attachment page" do
      get :add_attachment, :id => @d1.id
      response.should render_template :add_attachment
      response.should have_tag("table.content_table")
      response.should have_tag("table.content_table th", :count => 5)
      response.should have_tag "form[action=/deliverables/update/#{@d1.id}]" do
        with_tag "input[name='deliverable[attachment]']"
        with_tag "input#deliverable_submit"
      end
    end

=begin
    it "should update a deliverable with an attachment" do
      Deliverable.any_instance.stubs(:update_attributes).returns(true)
      @d2 = Deliverable.new :attachment => File.new(RAILS_ROOT + '/spec/fixtures/test_files/test_file.txt')
      @d2.id = 1
      @d2.phase = "System Design"
      get :update, :id => @d2.id, :deliverable => @d2
      flash[:notice].should == "Deliverable successfully uploaded!"
      response.should redirect_to :controller => :deliverables, 
        :action => :index,
        :default_phase => @d2.phase
    end
=end

    it "should not update a deliverable with an attachment" do
      Deliverable.any_instance.stubs(:update_attributes).returns(false)
      get :update, :id => @d1.id, :deliverable => @d1
      flash[:notice].should == "Deliverable did not upload correctly!"
      response.should redirect_to :controller => :deliverables,
        :action => :add_attachment,
        :id => @d1.id
    end
  end
end
