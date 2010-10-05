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
      flash[:notice] = "Successfully added an article"
    end
    
  end
  
  def edit
    @article = Article.find(params[:id])
    unless current_author == @article.author
      redirect_to(:root)
    end
  end

  def update
    @article = Article.find(params[:id])
    if current_author == @article.author
      respond_to do |format|
        if @article.update_attributes(params[:article])
          format.html { redirect_to(articles_path,
                        :notice => 'Article was successfully updated.') }
          format.xml  { head :ok }
        else
          format.html { render :action => "edit" }
          format.xml  { render :xml => @article.errors,
                        :status => :unprocessable_entity }
        end
      end
    else
      redirect_to(:root)
      
    end
    
  end

end
