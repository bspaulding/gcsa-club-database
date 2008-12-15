# Filters added to this controller apply to all controllers in the application.
# Likewise, all the methods added will be available for all controllers.

class ApplicationController < ActionController::Base
  helper :all # include all helpers, all the time

  # See ActionController::RequestForgeryProtection for details
  # Uncomment the :secret if you're not using the cookie session store
  protect_from_forgery # :secret => '5eebc9699e9839fe3986dcdc2bdce3f9'
  
  # See ActionController::Base for details 
  # Uncomment this to filter the contents of submitted sensitive data parameters
  # from your application log (in this case, all fields with names like "password"). 
  # filter_parameter_logging :password
  
  def check_authentication
    if session[:last_activity_time]
      timed_out = session[:last_activity_time] <= 5.minutes.ago.to_i
    else
      timed_out = false
    end
    
    unless session[:username] && !timed_out
      if timed_out
        flash[:notice] = "Your session has timed out. Please log in again."
      end
      if request.xhr?
        render :update do |page|
          page.redirect_to :controller => 'login', :action => 'index'
        end
      else
        redirect_to :controller => 'login', :action => 'index'
      end
    end
  end
end
