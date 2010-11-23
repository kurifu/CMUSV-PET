# Pushing this comment to sync this branch with master

require 'spec_helper'

describe UsersController do
integrate_views
setup :activate_authlogic

  describe "Regular user actions" do
    before(:each) do
      UserSession.stubs(:find).returns(UserSession.new)
      UserSession.any_instance.stubs(:user).returns(User.new)
      UserSession.any_instance.stubs(:save).returns(true)
      User.any_instance.stubs(:user_class).returns("Regular")
      post :create
    end

    it "should not allow regular user to view admin home screen" do
      response.should_not redirect_to(admin_home_path)
    end

    it "should not allow regular user to view users index screen" do
      response.should_not redirect_to("users/index")
    end

    it "should not allow regular user to create new users" do
      response.should_not redirect_to("users/new")
    end

    it "should not allow regular user to delete any user" do
      response.should_not redirect_to("users/destroy")
    end

    it "should not allow regular user to edit any user's details" do
      response.should_not redirect_to("users/edit")
    end

    it "should allow regular user to change his/her password" do
      response.should redirect_to(change_password_path)
    end
  end

  describe "Admin user actions" do
    before(:each) do
      UserSession.stubs(:find).returns(UserSession.new)
      UserSession.any_instance.stubs(:user).returns(User.new)
      UserSession.any_instance.stubs(:save).returns(true)
      User.any_instance.stubs(:user_class).returns("admin")
      post :create
    end

    it "should allow admin user to view all users' information" do
      response.should redirect_to("users/index")
    end

    it "should allow admin user to create new users" do
      response.should redirect_to("users/new")
    end

    it "should allow admin user to delete any user" do
      response.should redirect_to("users/destroy")
    end

    it "should allow admin user to edit any user's details" do
      response.should redirect_to("users/edit")
    end

    it "should allow admin user to change his/her password" do
      response.should redirect_to(change_password_path)
    end
  end
end

