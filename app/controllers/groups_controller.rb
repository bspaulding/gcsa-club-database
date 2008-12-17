class GroupsController < ApplicationController
  before_filter :check_authentication
  before_filter :check_authorization, :except => ['index', 'update_groups_list', 'update_group_detail']

  def index
    @groups = Cabinet.all
    @groups.sort! do |a,b|
      a.name <=> b.name
    end
  end

  def update_groups_list
    case params["group_type"]
      when "Cabinets"
        @groups = Cabinet.all
      when "Councils"
        @groups = Council.all
      when "Clubs"
        @groups = Club.all
      when "Publications"
        @groups = Publication.all
      else
        redirect_to :action => :index
    end
    @groups.sort! do |a,b|
      a.name <=> b.name
    end
    render :partial => 'groups/update_groups_list', :object => @groups
  end
  
  def update_group_detail
    @group = Group.find(params[:id])
    render :partial => 'groups/update_group_detail', :object => @group
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
        when "Club"
          @group = Club.create(params[:group])
        when "Council"
          @group = Council.create(params[:group])
        when "Cabinet"
          @group = Cabinet.create(params[:group])
        when "Publication"
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
    if params[:club]
      @group = Club.find(params[:id])
      @group.update_attributes(params[:club])
    elsif params[:council]
      @group = Council.find(params[:id])
      @group.update_attributes(params[:council])
    elsif params[:cabinet]
      @group = Cabinet.find(params[:id])
      @group.update_attributes(params[:cabinet])
    else
      @group = Publication.find(params[:id])
      @group.update_attributes(params[:publication])
    end
    if @group.save
      flash[:notice] = 'Post was successfully updated.'
      redirect_to group_path(@group)
    else
      render :action => 'edit'
    end
  end

  def destroy
    group = Group.destroy(params[:id])
    flash[:notice] = "'#{group.name}' was deleted."
    redirect_to :action => :index
  end

end
