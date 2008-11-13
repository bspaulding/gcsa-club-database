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
      @group = Group.new(params[:group])
      if @group.save
        flash[:notice] = 'Post was successfully created.'
        redirect_to @group
      else
        render :action => 'new'
      end
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
