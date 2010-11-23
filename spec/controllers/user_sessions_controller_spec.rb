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

  describe "Valid Admin User" do
    before(:each) do
      UserSession.stubs(:find).returns(UserSession.new)
      UserSession.any_instance.stubs(:user).returns(User.new)
      UserSession.any_instance.stubs(:save).returns(true)
      User.any_instance.stubs(:user_class).returns("admin")
      post :create
    end

    it "should redirect admin to admin home screen" do
      response.should redirect_to(admin_home_path)
    end

  end

  describe "Valid Regular User" do
    before(:each) do
      UserSession.stubs(:find).returns(UserSession.new)
      UserSession.any_instance.stubs(:user).returns(User.new)
      UserSession.any_instance.stubs(:save).returns(true)
      User.any_instance.stubs(:user_class).returns("Regular")
      post :create
    end

    it "should redirect user to User home screen" do
      response.should redirect_to(root_path)
    end

    it "should not redirect regular user to admin home screen" do
      response.should_not redirect_to(admin_home_path)
    end
  end  
end