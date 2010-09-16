class ArticlesController < ApplicationController

  respond_to :html, :xml
  respond_to :js, :only => [:create]

  before_filter :authenticate_author!, :only => [:create]

  def index
    @articles = Article.where(:published => true).order('created_at DESC').paginate(:page => params[:page])
    @article = Article.new
    @author = Author.new
  end
  
  def new
  end


  def create
    @article = Article.new(params[:article])
    # change this to current user logged in
    # current_author.whatever
    @article.author = current_author
    # @article.author = Author.find_or_create_by_email(params[:author])
    if @article.save 
      flash[:notice] = "Success"
    end
    
  end

end
