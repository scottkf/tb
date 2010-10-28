class CategoriesController < ApplicationController
  load_and_authorize_resource :except => [:list, :layouts]

  before_filter :organized, :only => [:edit, :new]
  
  def index
    # @categories = Category.all if can? :index, Category
    @categories = Category.all.each { |c| c.ancestry = c.ancestry.to_s + (c.ancestry != nil ? "/" : '') + c.id.to_s 
      }.sort {|x,y| x.ancestry <=> y.ancestry 
      } if can? :index, Category
  end

  def show
  end

  def new
    render :layout => nil if params[:js]
  end

  def edit
    @arranged = @arranged.delete_if {|c| c[1] == @category.id}
  end

  def create
    @category = Category.new(params[:category])
 
    if @category.save
      flash[:notice] = "The category has been created"
      respond_to do |format|
        format.js
        format.xml  { head :ok }
        format.html { redirect_to categories_url }
      end
    else
      respond_to do |format|
        format.js
        format.xml  { head :ok }
        format.html { render :action => :new, :status => :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
       if @category.errors[:base].empty? and @category.update_attributes(params[:category])
         flash[:notice] = "The category has been updated"
         format.json { render :json => @category.to_json, :status => 200 }
         format.xml  { head :ok }
         format.html { redirect_to categories_url }
       else
         format.json { render :text => "Could not update category", :status => :unprocessable_entity } #placeholder
         format.xml  { render :xml => @category.errors, :status => :unprocessable_entity }
         format.html { render :action => :edit, :status => :unprocessable_entity }
       end
     end
   end


  def destroy
    respond_to do |format|
      format.json { render :text => "This is currently not allowed", :status => :unprocessable_entity } # placeholder
      format.xml  { head :ok }
      format.html { redirect_to categories_url }
    end
  end

  def list
    @category = Category.find_by_url(params[:category_url])
    if @category and 
      ((@articles = Article.published.where(:category_id => [@category.id.to_s,@category.child_ids].flatten).paginate :page => params[:page], :per_page => 10).size > 0) and 
      File.exists? Rails.root.join("app", "views", "layouts","#{@category.layout}.html.erb")
      render :layout => "#{@category.layout}" if @articles 
      #get all articles belonging to category, paginated
      #check if the url is a subcategory, if it is, just get subcats
    else
      redirect_to articles_path
    end
  end
  
  
  private
  def organized
    @arranged = arranged_categories if can? :read, Category
  end
  
  
end
