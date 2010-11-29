class UserSessionsController < ApplicationController

  #Render the login page
  def new
    @user_session = UserSession.new
  end

  #Login a particular user
  def create
    @user_session = UserSession.new(params[:user_session])
    
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      #puts "Current user admin #{current_user_admin}"
      if current_user_admin
        redirect_back_or_default admin_home_path
      else
        redirect_to :controller => 'users', :action => 'home'
      end
    else
      flash[:notice] = "Invalid username/password"
      render :action => 'new'
    end
  end

  #Action for logging out
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Logged out"
    redirect_to login_path
  end
end
