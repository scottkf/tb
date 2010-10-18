require 'spec_helper'


describe Article do
  
  before(:all) do
    @layouts = Dir[Rails.root.join("app", "views", "layouts","*")]
  end
  
  after(:all) do
    @new_layouts = Dir[Rails.root.join("app", "views", "layouts","*")]
    @new_layouts.map { |f| f if !@layouts.include? f }.compact.each do |f|
      File.delete(f) if File.exists? f
    end
  end

  context "#valid" do
    it "should have a title" do
      @article = Article.make(:title => nil)
      @article.save
      @article.should_not be_valid
      @article.should have(1).error_on(:title)
      @article.title = "hello"
      @article.should be_valid
    end
    it "should have a body" do
      @article = Article.make(:body => nil)
      @article.save
      @article.should_not be_valid
      @article.should have(1).error_on(:body)
      @article.body = "hello"
      @article.should be_valid
    end
    it "should have a user" do
      @article = Article.make(:user => nil)
      @article.should_not be_valid
      @article.should have(1).error_on(:user)
      @article.user = User.make!
      @article.save
      @article.should be_valid
    end
    it "should have a category" do
      @article = Article.make(:category => nil)
      @article.should_not be_valid
      @article.should have(1).error_on(:category)
      @article.category = Category.make!
      @article.save
      @article.should be_valid      
    end
  end
  
  context "#markdown" do
    it "should process markdown correctly" do
      @article = Article.make(:body => "_hello_")
      @article.save
      @article.rendered_body.should == "<p><em>hello</em></p>\n"
    end
  end
end
