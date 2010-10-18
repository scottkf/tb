class CategoriesController < ApplicationController
  load_and_authorize_resource :except => [:list]

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
    @layout = params[:category_url]
    if File.exists? Dir[Rails.root.join("app", "views", "layouts","#{@layout}")]
      #get all articles belonging to category, paginated
      #check if the url is a subcategory, if it is, just get subcats
    else
      redirect_to articles_path
    end
  end

  private
  def article_layout
    @layout
  end

end
