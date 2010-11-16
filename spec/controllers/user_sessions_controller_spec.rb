require 'spec_helper'


describe UserSessionsController do
  integrate_views

  setup :activate_authlogic

  describe "Invalid User" do
    before(:each) do
      UserSession.any_instance.stubs(:save).returns(false)
      post :create
    end
    it "should not allow access to User Home Screen" do
      response.should render_template("user_sessions/new")
    end
    it "should display an error message" do
      flash[:notice].should == "Invalid username/password"
      
    end
  end

  describe "Valid User" do

    it "should redirect user to User home screen" do
      UserSession.any_instance.stubs(:save).returns(true)
      post :create
      response.should redirect_to(root_path)

    end
    it "logout valid user and show proper message" do
      attr = {:username=>'invalid', :password=>'invalid'}
      user_session = UserSession.new(attr)
      UserSession.stubs(:find).returns(user_session)
      delete :destroy
      #flash[:notice].should == "Logged out"
      response.should redirect_to(root_path)

    end
  end
  
  
end