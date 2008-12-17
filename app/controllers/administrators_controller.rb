class AdministratorsController < ApplicationController
  before_filter :check_authentication, :check_authorization
  
  def index
    @admins = Administrator.all
    @new_admin = Administrator.new
  end
  
  def create
    # Create the administrator
    admin = Administrator.new(params[:administrator])
    # Verify its a valid user
    students = User.find_by_email(admin.username, session[:username], session[:password])
    if students.size == 0 
      flash[:error] = "'#{admin.username}' is not a valid user."
      render :update do |page|
        page.redirect_to :action => 'index'
      end
    elsif admin.save
      render :update do |page|
        page.insert_html :bottom, 'admins_list_ul', :partial => 'administrators/admin_listing', :object => admin
        page.visual_effect :highlight, "administrator_#{admin.id}", :duration => 1.0
      end
    else
      # there was an issue saving admin
      flash[:error] = "There was an issue saving. This user may already be an administrator."
    end
  end
  
  def destroy
    begin
      Administrator.destroy(params[:id])
    rescue
      flash[:error] = "You can't delete the last administrator."
    end
    redirect_to :action => 'index'
  end
end
