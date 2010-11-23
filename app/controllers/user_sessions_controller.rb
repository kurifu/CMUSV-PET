class UserSessionsController < ApplicationController


  def index
    
  end
  def new
    @user_session = UserSession.new
  end

  def create
    @user_session = UserSession.new(params[:user_session])
    
    if @user_session.save
      flash[:notice] = "Successfully logged in."
      puts "Current user admin #{current_user_admin}"
      if current_user_admin
      redirect_to admin_home_path
      else
        redirect_to root_path
      end
    else
      flash[:notice] = "Invalid username/password"
      render :action => 'new'
    end
  end
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Logged out"
    redirect_to login_path
  end


end
