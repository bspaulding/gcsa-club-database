class LoginController < ApplicationController
  def index
  end

  def login
    if !User.authenticate(params[:username], params[:password])
      flash[:notice] = "Login Failed. Username/Password combination incorrect."
      redirect_to :action => 'index'
    else
      session[:username] = params[:username]
      session[:password] = params[:password]
      session[:last_activity_time] = Time.now.to_i
      redirect_to :controller => 'groups', :action => 'index'
    end
  end

  def logout
    session[:username] = false
    session[:password] = false
    redirect_to :action => :index
  end

end
