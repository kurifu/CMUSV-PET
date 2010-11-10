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
      redirect_to "/projects"
    else
      render :action => 'new'
    end
  end
  def destroy
    @user_session = UserSession.find
    @user_session.destroy
    flash[:notice] = "Logged out"
    redirect_to root_path
  end

end
