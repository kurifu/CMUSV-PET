# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery # See ActionController::RequestForgeryProtection for details

  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password

  helper_method :current_user
  private
  def current_user_session
    return @current_user_session if defined?(@current_user_session)
    @current_user_session = UserSession.find
  end

  def current_user
    return @current_user if defined?(@current_user)
    @current_user = @current_user_session &&
                    @current_user_session.record
  end

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
end
