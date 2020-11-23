# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time
  protect_from_forgery
  
    
  protected
  def authorize
    unless User.find_by_id(session[:user_id])
        session[:original_uri] = request.request_uri
        flash[:notice] = t(:login_please_message)
        redirect_to(:controller => "admin" , :action => "login" )
    end
  end
  # Scrub sensitive parameters from your log
  # filter_parameter_logging :password
end
