class GroupsController < ApplicationController
  before_filter :check_authentication

  def index
    @groups = Group.all
  end

  def show
    @group = Group.find(params[:id])
  end

  def new
    @group = Group.new
  end

  def create
    if request.post?
      case params[:group][:type]
        when "club"
          @group = Club.create(params[:group])
        when "council"
          @group = Council.create(params[:group])
        when "cabinet"
          @group = Cabinet.create(params[:group])
        when "publication"
          @group = Publication.create(params[:group])
      end      
      if @group.save
        flash[:notice] = 'Post was successfully created.'
        redirect_to group_path(@group)
      else
        render :action => 'new'
      end
    end
  end

  def edit
    @group = Group.find(params[:id])
  end

  def update
    Group.find(params[:group][:id]).update_attributes(params[:group])
  end

  def destroy
  end

end
