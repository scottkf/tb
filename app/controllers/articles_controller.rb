class ArticlesController < ApplicationController

  respond_to :html, :xml
  respond_to :js, :only => [:create]

  def index
    @articles = Article.published.paginate :page => params[:page], :per_page => 10
    @article = Article.new
    @categories = arranged_categories if can? :create, Article
  end
  

  def show
    @article = Article.find(params[:id])
    render :layout => "#{@article.category.layout}" if File.exists? Rails.root.join("app", "views", "layouts","#{@article.category.layout}.html.erb")
  end

  def create
    @article = Article.new(params[:article])
    authorize! :create, Article
    @article.user = current_user
    if @article.save 
      flash[:notice] = "Successfully added an article"
    end
    
  end
  
  def edit
    @article = Article.find(params[:id])
    @categories = arranged_categories
    authorize! :manage, Article
    session[:return_to] = request.referer
  end

  def update
    @article = Article.find(params[:id])
    authorize! :manage, Article
    params[:article][:user][:role_ids] = [] if params[:article][:user]
     respond_to do |format|
       if @article.update_attributes(params[:article])
         format.html { 
           redirect_to(session[:return_to], :notice => 'Article was successfully updated.') 
         }
         format.xml  { head :ok }
       else
         format.html { render :action => "edit" }
         format.xml  { render :xml => @article.errors,
                       :status => :unprocessable_entity }
       end
     end
   end
  
  def all
    @articles = Article.ordered(params[:sort]).paginate :page => params[:page], :per_page => 10
    authorize! :manage, Article
  end
  
  def text_styles
    render :layout => false
  end

end
