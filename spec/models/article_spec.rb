require 'spec_helper'

module ArticleSpecHelper
  def valid_article_attributes
    { :title => "My awesome title",
      :body => "_awesome_",
      :user => User.create(valid_author_attributes) }
  end
  
  def valid_author_attributes
    { :first_name => "Bob", 
      :last_name => "Jones", 
      :email => "bobjones@hot.com", 
      :password => "bob123", 
      :password_confirmation => "bob123" }
  end
end

describe Article do
  include ArticleSpecHelper
  
  before(:each) do
    @article = Article.new
  end
  
  context "#valid" do
    it "should have a title" do
      @article.attributes = valid_article_attributes.except(:title)
      @article.save
      @article.should_not be_valid
      @article.should have(1).error_on(:title)
      @article.title = "hello"
      @article.should be_valid
    end
    it "should have a body" do
      @article.attributes = valid_article_attributes.except(:body)
      @article.save
      @article.should_not be_valid
      @article.should have(1).error_on(:body)
      @article.body = "hello"
      @article.should be_valid
    end
  end
  
  context "#markdown" do
    it "should process markdown correctly" do
      @article.attributes = valid_article_attributes
      @article.save
      @article.rendered_body.should == "<p><em>awesome</em></p>\n"
    end
  end
end
