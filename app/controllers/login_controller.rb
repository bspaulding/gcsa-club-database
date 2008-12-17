class LoginController < ApplicationController
  def index
  end

  def login
    begin
      if !User.authenticate(params[:username], params[:password])
        flash[:error] = "Login Failed. Username/Password combination incorrect."
        redirect_to :action => 'index'
      else
        session[:username] = params[:username]
        session[:password] = params[:password]
        session[:is_admin] = Administrator.is_admin(params[:username])
        session[:last_activity_time] = Time.now.to_i
        redirect_to :controller => 'groups', :action => 'index'
      end
    rescue Net::LDAP::LdapError
      flash[:error] = "Cannot connect to Directory Server. Please try again later."
      redirect_to :action => 'index'
    end
  end

  def logout
    session[:username] = false
    session[:password] = false
    redirect_to :action => :index
  end

end
