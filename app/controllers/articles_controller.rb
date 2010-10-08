class ArticlesController < ApplicationController

  respond_to :html, :xml
  respond_to :js, :only => [:create]
  authorize_resource :only => [:create, :edit, :update]

  def index
    @articles = Article.where(:published => true).order('created_at DESC').paginate(:page => params[:page])
    @article = Article.new
  end
  


  def create
    @article = Article.new(params[:article])
    # change this to current user logged in
    # current_author.whatever
    @article.user = current_user
    # @article.author = Author.find_or_create_by_email(params[:author])
    if @article.save 
      ## don't need this because it's handled by JS atm
      flash[:notice] = "Successfully added an article"
    end
    
  end
  
  def edit
    @article = Article.find(params[:id])
    unless current_user == @article.user
      redirect_to(:root)
    end
  end

  def update
    @article = Article.find(params[:id])
    if current_user == @article.user
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
  
  def text_styles
    render :layout => false
  end

end
