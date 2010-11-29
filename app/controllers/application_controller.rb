# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
  helper_method :current_user_session, :current_user
  protected

  #Code for error handling. Over the rescue_action method can catch all exception
  #in one place
  def rescue_action(exception)
    puts exception
    case exception
    when ActiveRecord::RecordNotFound, ActionController::UnknownAction, ActionController::RoutingError
      redirect_to "/error", :status=>301
    else
      redirect_to "/500.html"
    end
  end

  #Return the current user session. Called from the current_user method
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  #Return the current user object. It contains all the data for a particular user.
  #The user object is stored in the related user session object.
  def current_user
    return @current_user if defined?(@current_user)
    @current_user = current_user_session && current_user_session.user
  end

  #Filter method to prevent user access unauthorized pages. Defined in the
  #application controller so that all the controller can access this method.
  #Usage: before_filter :requie_user
  #If the user doesn't log in it will be redirected to the login page
  def require_user
    unless current_user
      store_location
      flash[:notice] = "You must be logged in to access this page"

#        redirect_to new_user_session_url
      redirect_to login_path
      return false
    end
  end

  #Store the current location of the current request. For the use in future
  #redirect.
  def store_location
    session[:return_to] = request.request_uri
  end

  #Redirect back to the stored location. If there is no stored location, it will
  #redirected to the default url.
  def redirect_back_or_default(default)
    redirect_to(session[:return_to] || default)
    session[:return_to] = nil
  end

  #Method specific to PET1.3. Used to prevent non admin user to access certain pages
  #with admin functionalities.
  #Usage before_filter :require_admin
  def require_admin
    unless current_user_admin
      redirect_to "/access_denied.html"
      return false
    end
  end

  #Method to check whether current is admin or not
  def current_user_admin
    #if "admin".casecmp(current_user.user_class)
    if current_user.user_class == "admin"
      return true
    end
  end

end
