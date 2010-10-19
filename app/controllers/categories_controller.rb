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
    @category = Category.find_by_name(params[:category_url])
    if File.exists? Rails.root.join("app", "views", "layouts","#{@category.layout}.html.erb")
      @articles = Article.find_by_category_id(@category.id)
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
