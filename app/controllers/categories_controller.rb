class CategoryController < ApplicationController
  load_and_authorize_resource

  layout :article_layout, :only => [:list]
  
  def index
  end

  def show
  end

  def create
  end

  def update
  end

  def edit
  end

  def destroy
  end

  def list
    @layout = params[:name]
  end

  private
  def article_layout
    @layout
  end

end
