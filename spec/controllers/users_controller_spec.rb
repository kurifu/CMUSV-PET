# Pushing this comment to sync this branch with master

require 'spec_helper'

describe UsersController do

  setup :activate_authlogic

  before(:each) do

  end

  describe "Admin actions" do
    before(:each) do
      UserSession.stubs(:find).returns(UserSession.new)
      UserSession.any_instance.stubs(:user).returns(User.new)
      UserSession.any_instance.stubs(:save).returns(true)
      User.any_instance.stubs(:user_class).returns("admin")
    end

    it "should render index page for user controller" do
      get :index
      response.should render_template :index
    end

    it "should render new page when request new" do
      get :new
      response.should render_template :new
    end

    it "should render edit page" do
      user = mock()
      User.stubs(:find).returns(user)
      get :edit, :id=>1
      response.should render_template :edit
    end

    it "should redirect to show page when save success" do
      User.any_instance.stubs(:save).returns(true)
      post :create, :id=>1
      response.should redirect_to "/users"
    end

    it "should render new when save fail" do
      User.any_instance.stubs(:save).returns(false)
      post :create, :id=>1
      response.should render_template :new
    end

    it "should redirect to users when update success" do
      User.stubs(:find).returns(User.new)
      User.any_instance.stubs(:update_attributes).returns(true)
      put :update, :id=>1
      response.should redirect_to "/users"
    end

    it "should redirect to users when update fail" do
      User.stubs(:find).returns(User.new)
      User.any_instance.stubs(:update_attributes).returns(false)
      put :update, :id=>1
      response.should render_template :edit
    end

    it "should go to user_url when delete success" do
      User.stubs(:find).returns(User.new)
      delete :destroy
      response.should redirect_to users_url
    end

    it "should go to admin projects" do
      get :admin_projects
      response.should render_template :admin_projects
    end

    it "should go to transfer project" do
      Project.stubs(:find).returns(Project.new)
      User.stubs(:find).returns(User.new)
      get :transfer_project
      response.should render_template :transfer_project
    end

    it "should redirect to admin projects when assign success" do
      Project.any_instance.stubs(:save).returns(true)
      Project.stubs(:find).returns(Project.new)
      get :assign, :id=>1
      response.should redirect_to :action=>:admin_projects
    end

    it "should render to transfer_projects when assign faild" do
      Project.any_instance.stubs(:save).returns(false)
      Project.stubs(:find).returns(Project.new)
      get :assign, :id=>1
      response.should render_template :transfer_projects
    end

  end

  it "should go to home" do
    UserSession.stubs(:find).returns(UserSession.new)
    UserSession.any_instance.stubs(:user).returns(User.new)
    get :home
    response.should render_template :home
  end

  it "should go to change password" do
     @user_session = UserSession.create Factory.build(:valid_user)
    get :change_password
    response.should render_template :change_password
  end

  it "should go to root path when update_password succeess" do
    UserSession.stubs(:find).returns(UserSession.new)
      UserSession.any_instance.stubs(:user).returns(User.new)
    User.any_instance.stubs(:update_attributes).returns(true)

    get :update_password
    response.should redirect_to root_path
  end

  it "should render change_password when update_password failed" do
    UserSession.stubs(:find).returns(UserSession.new)
      UserSession.any_instance.stubs(:user).returns(User.new)
    User.any_instance.stubs(:update_attributes).returns(false)

    get :update_password
    response.should render_template :change_password
  end
  
  it "should show user profile for either user class" do
    @user_session = UserSession.create Factory.build(:valid_user)

    get :show, :id=>4
    response.should render_template :show
  end


  it "should not allow regular user to view certain pages" do
    UserSession.stubs(:find).returns(UserSession.new)
      UserSession.any_instance.stubs(:user).returns(User.new)
      UserSession.any_instance.stubs(:save).returns(true)
      User.any_instance.stubs(:user_class).returns("Regular")
    get :admin_home
    response.should redirect_to "/access_denied.html"
  end
end

