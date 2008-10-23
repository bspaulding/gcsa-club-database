class CategoriesController < ApplicationController
  def index
    @categories = Category.all
  end

  def show
  end

  def create
    if request.post?
      # Save new 
    else
      # Create new
      
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end

end
