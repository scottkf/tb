class ArticlesController < ApplicationController
  def index
    @articles = Article.where(:published => true).paginate(:page => params[:page])
  end

  def new
  end

end
