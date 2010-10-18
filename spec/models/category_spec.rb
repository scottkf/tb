require 'spec_helper'

describe Category do
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
    describe "presence" do
      it "should have a valid name" do
        c = Category.make(:name => nil)
        c.save
        c.should_not be_valid
        c.should have(1).error_on(:name)
        c.name = "hello"
        c.save
        c.should be_valid        
      end
      it "should have a valid description" do
        c = Category.make(:description => nil)
        c.save
        c.should_not be_valid
        c.should have(1).error_on(:description)
        c.description = "hello"
        c.save
        c.should be_valid        
      end
      it "should have a valid url" do
        c = Category.make(:url => nil)
        c.save
        c.should_not be_valid
        c.should have(3).errors_on(:url)
        c.url = "hello"
        c.save
        c.should be_valid        
      end
      it "should have a valid layout" do
        c = Category.make(:layout => nil)
        c.save
        c.should_not be_valid
        c.should have(1).error_on(:layout)
        c.layout = "hello"
        c.save
        c.should be_valid        
      end
    end
    describe "name" do
      it "should be unique" do
        c = Category.make!(:name => "hello")
        c.should be_valid
        c = Category.make(:name => "hello")
        c.save
        c.should_not be_valid
      end
    end
    describe "layout" do
      it "should be a valid filename (or create one if it doesn't exist)" do
        c = Category.make!(:layout => "default")
        File.exists?(Rails.root.join("app", "views", "layouts","#{c.layout}.html.erb")).should be true
      end
    end
    describe "url" do
      it "should be unique" do
        c = Category.make!(:url => "hello")
        c.should be_valid
        c = Category.make(:url => "hello")
        c.save
        c.should_not be_valid        
      end
      it "should contain valid characters" do
        c = Category.make(:url => "!!!!")
        c.save
        c.should_not be_valid
        c.should have(1).error_on(:url)
        c.url = "hello"
        c.save
        c.should be_valid
      end
      it "should be the proper length" do
        c = Category.make(:url => "1")
        c.save
        c.should_not be_valid
        c.should have(1).error_on(:url)
        c.url = "1234567890123"
        c.save
        c.should_not be_valid
        c.should have(1).error_on(:url)        
        c.url = "hello"
        c.save
        c.should be_valid
      end
    end
  end
end
