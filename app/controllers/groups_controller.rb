class GroupsController < ApplicationController
  before_filter :check_authentication

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
  end
  
  def update_group_detail
    @group = Group.find(params[:id])
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
  end

end
