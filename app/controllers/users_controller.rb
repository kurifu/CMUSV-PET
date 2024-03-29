class UsersController < ApplicationController
before_filter :require_user
before_filter :require_admin, :except => [:show, :home, :change_password, :update_password]

  # GET /users
  # GET /users.xml
  # List all the users for admin user management
  def index
    @users = User.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @users }
    end
  end

  # GET /users/1
  # GET /users/1.xml
  # show detailed information of a particular user
  def show
    @user = User.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/new
  # GET /users/new.xml
  # Render new page for admin to add new user to PET
  def new
    @user = User.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @user }
    end
  end

  # GET /users/1/edit
  # Admin can edit user's information
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.xml
  # Action to create an entry in database
  def create
    @user = User.new(params[:user])

    respond_to do |format|
      if @user.save
        format.html { redirect_to(@user, :notice => 'User was successfully created.') }
        format.xml  { render :xml => @user, :status => :created, :location => @user }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /users/1
  # PUT /users/1.xml
  # Update an existing entry in a database
  def update
    @user = User.find(params[:id])

    respond_to do |format|
      if @user.update_attributes(params[:user])
          format.html { redirect_to(@user, :notice => 'User was successfully updated.') }
          format.xml  { head :ok }
      else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @user.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.xml
  # Delete an existing user
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    respond_to do |format|
      format.html { redirect_to(users_url) }
      format.xml  { head :ok }
    end
  end

  # Home page for regular user. Showing information of the user profile
  def home
    @projects = current_user.projects.find(:all)
  end

  # For current user to change password
  def change_password
      @user = current_user
  end

  # Change the password column in the databse
  def update_password
    @user = current_user
      respond_to do |format|
      if @user.update_attributes(params[:user])
          format.html { redirect_to(root_path,
              :notice => 'Password was successfully updated.') }
          format.xml  { head :ok }
      else
        format.html { render :action => "change_password" }
        format.xml  { render :xml => @user.errors,
          :status => :unprocessable_entity }
      end
    end
  end

  # Listing all the projects for a admin to manage
  # admin can edit delete or transfer an existing project
  def admin_projects
    @projects = Project.all
  end

  # Transfer project from one user to the other
  def transfer_project
    @project = Project.find(params[:id])
    @users = User.find(:all, :conditions => "user_class = 'Regular'")
    @project_user_name = User.find(@project.user_id).username
  end

  # Render home page for admin, displaying profile information
  def admin_home
    
  end

  # Assign action to transfer an project
  def assign
    project = Project.find(params[:project_id])
    project.user_id = params[:user_id]

    if project.save
      flash[:notice] = "Successfully Assigned the project"
      redirect_to :action=>'admin_projects'
    else
      render 'transfer_projects'
    end
  end

  # Action for instant search
  def search
    session[:query] = params[:query].strip if params[:query]

    if session[:query] and request.xhr?
      @users = Project.find(:all, :conditions => ['name LIKE ? or lifecycle LIKE ?', "%#{session[:query]}%", "%#{session[:query]}%"])
    end
    if params[:query] == ""
      @users = Project.find(:all)
    end
     render :partial => "searchresults", :layout => false, :locals => {:searchresults => @users, :projects => @projects}
  end

end
