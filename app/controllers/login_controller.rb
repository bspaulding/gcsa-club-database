class LoginController < ApplicationController
  def index
  end

  def login
    if !User.authenticate(params[:username], params[:password])
      flash[:notice] = "Login Failed. Username/Password combination incorrect."
      redirect_to :action => 'index'
    else
      session[:username] = params[:username]
      redirect_to :controller => 'groups', :action => 'index'
    end
  end

end
